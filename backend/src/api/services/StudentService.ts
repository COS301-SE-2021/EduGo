import { In, Repository } from "typeorm";
import { validateEmails } from "./validations/EmailValidate";
import { Subject } from "../database/Subject";
import { UnverifiedUser } from "../database/UnverifiedUser";
import { User } from "../database/User";
import { DatabaseError } from "../errors/DatabaseError";
import { EmailError } from "../errors/EmailError";
import { EmailService } from "../helper/email/EmailService";
import { MockEmailService } from "../helper/email/MockEmailService";
import { AddedToSubjectEmail } from "../helper/email/models/AddedToSubjectEmail";
import { VerificationEmail } from "../helper/email/models/VerificationEmail";
import { AddStudentsToSubjectRequest } from "../models/user/AddStudentToSubjectRequest";
import { EmailList } from "../models/user/SerivceModels";
import { Service, Inject } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import { Organisation } from "../database/Organisation";
import { Educator } from "../database/Educator";
import { Student } from "../database/Student";

/**
 * A class consisting of the functions that make up the student service
 * @class StudentService
 */
@Service()
export class StudentService {
	@InjectRepository(Subject) private subjectRepository: Repository<Subject>;
	@InjectRepository(User) private userRepository: Repository<User>;
	@InjectRepository(Organisation)
	private organisationRepository: Repository<Organisation>;
	@InjectRepository(Educator)
	private educatorRepository: Repository<Educator>;
	@InjectRepository(Student) private studentRepository: Repository<Student>;
	@InjectRepository(UnverifiedUser)
	private unverifiedUserRepository: Repository<UnverifiedUser>;

	//TODO check error regarding mockEmailService injectable
	@Inject("mailgunEmailService")
	emailService: EmailService;

	/**
	 * @param {request} request - A request consisting of the organisation id and an array of email strings
	 * @param {string[]} request.emails - An array of educator email addresses (unvalidated)
	 * @param {number} request.subject_id - The id of the subject the users are being added to
	 * @returns {Promise<void>}
	 * @description Add users to a subject using their student email addresses
	 * 1. The emails will be validated
	 * 2. The emails will be categorised and stored in a list
	 * 3. Each category will be handled by an appropriate handler function
	 */
	public async AddUsersToSubject(
		request: AddStudentsToSubjectRequest
	): Promise<void> {
		let emails: string[] = request.students;

		if (validateEmails(emails)) {
			this.CategoriseStudentsFromEmails(emails).then((list) => {
				this.HandleVerifiedStudents(list.verified, request.subject_id);
				this.HandleUnverifiedStudents(
					list.unverified,
					request.subject_id
				);
				this.HandleNonexistentStudents(
					list.nonexistent,
					request.subject_id
				);
			});
		}
	}

	/**
	 * @param {string[]} emails - An array of emails of registered students
	 * @param {number} id - The subject id of the subject the students are added to
	 * @throws {EmailError} Not all the emails could be sent
	 * @throws {DatabaseError} The subject could not be found in the database
	 * 1. Find the subject in the repository using the id, include the students and students.user relations
	 * 2. List all of the users currently enrolled to the subject
	 * 3. Get the users not currently enrolled to the subject by filtering from the 'ALL' list
	 * 4. Get the user objects of all the non enrolled students
	 * 5. Enroll the students
	 * 6. Send emails by invoking the SendBulkAddedToSubjectEmails function from the email service
	 */
	private async HandleVerifiedStudents(
		emails: string[],
		id: number
	): Promise<void> {
		this.subjectRepository
			.findOne(id, {
				relations: ["students", "students.user"],
			})
			.then((subject) => {
				if (!subject) throw new DatabaseError("Could not find subject");

				let allEnrolledUserEmails: string[] = subject.students.map(
					(value) => value.user.email
				);
				let nonEnrolledUserEmails: string[] = emails.filter(
					(value) => !allEnrolledUserEmails.includes(value)
				);

				this.userRepository
					.find({
						where: { email: In(nonEnrolledUserEmails) },
						relations: ["student"],
					})
					.then((users) => {
						subject.students.push(
							...users.map((value) => value.student)
						);
						let addedToSubjectEmails: AddedToSubjectEmail[] =
							users.map((value) => {
								return {
									email: value.email,
									name: value.firstName,
									subject: subject.title,
								};
							});

						this.subjectRepository.save(subject).then(() => {
							this.emailService
								.SendBulkAddedToSubjectEmails(
									addedToSubjectEmails
								)
								.then((result) => {
									if (!result)
										throw new EmailError(
											"Could not send all emails"
										);
								});
						});
					});
			});
	}

	/**
	 * @param {string[]} emails - An array of emails of unverified educators
	 * @param {number} id - The subject id of the subject the students are added to
	 * @throws {EmailError} Not all the emails could be sent
	 * @throws {DatabaseError} The subject could not be found in the database
	 * @description
	 */
	private async HandleUnverifiedStudents(
		emails: string[],
		id: number
	): Promise<void> {
		this.subjectRepository
			.findOne(id, {
				relations: ["unverifiedUsers"],
			})
			.then((subject) => {
				if (!subject) throw new DatabaseError("Could not find subject");

				let allEnrolledUnverifiedEmails: string[] =
					subject.unverifiedUsers.map((value) => value.email);

				let nonEnrolledUnverifiedEmails: string[] = emails.filter(
					(value) => !allEnrolledUnverifiedEmails.includes(value)
				);

				this.unverifiedUserRepository
					.find({ where: { email: In(nonEnrolledUnverifiedEmails) } })
					.then((users) => {
						let unverifiedEmails: VerificationEmail[] = users.map(
							(value) => {
								return {
									code: value.verificationCode,
									email: value.email,
								};
							}
						);
						subject.unverifiedUsers.push(...users);

						this.subjectRepository.save(subject).then(() => {
							this.emailService
								.SendBulkVerificationReminderEmails(
									unverifiedEmails
								)
								.then((result) => {
									if (!result)
										throw new EmailError(
											"Could not send all emails"
										);
								});
						});
					});
			});
	}

	//Precondition: all the emails given are already known to NOT exists, so checking if they
	//exist is unnecessary
	private async HandleNonexistentStudents(
		emails: string[],
		id: number
	): Promise<void> {
		this.subjectRepository
			.findOne(id, {
				relations: ["unverifiedUsers", "organisation"],
			})
			.then((subject) => {
				if (!subject) throw new DatabaseError("Could not find subject");

				let unverifiedUsers: UnverifiedUser[] = emails.map((value) => {
					let user: UnverifiedUser = new UnverifiedUser();
					user.email = value;
					user.verificationCode = this.generateCode(5);
					user.organisation = subject.organisation;
					user.type = "student";
					return user;
				});

				let unverifiedEmails: VerificationEmail[] = unverifiedUsers.map(
					(value) => {
						return {
							code: value.verificationCode,
							email: value.email,
						};
					}
				);

				this.unverifiedUserRepository.save(unverifiedUsers).then(() => {
					this.emailService
						.SendBulkVerificationEmails(unverifiedEmails)
						.then((result) => {
							if (!result)
								throw new EmailError(
									"Could not send all emails"
								);
						});
				});
			});
	}

	private async CategoriseStudentsFromEmails(
		emails: string[]
	): Promise<EmailList> {
		let list: EmailList = {
			verified: [],
			unverified: [],
			nonexistent: [],
		};

		return this.userRepository
			.find({ where: { email: In(emails) } })
			.then((users) => {
				list.verified = users.map((value) => value.email);
				let withoutVerified: string[] = emails.filter(
					(value) => !list.verified.includes(value)
				);

				return this.unverifiedUserRepository
					.find({ where: { email: In(withoutVerified) } })
					.then((users) => {
						list.unverified = users.map((value) => value.email);
						list.nonexistent = withoutVerified.filter(
							(value) => !list.unverified.includes(value)
						);

						return list;
					});
			});
	}

	private generateCode(length: number): string {
		let charset = "0123456789";
		let result = "";
		for (let i = 0; i < length; i++)
			result += charset[Math.floor(Math.random() * charset.length)];
		return result;
	}
}
