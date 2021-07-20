import { EmailService } from "./EmailService";
import { getRepository, In } from "typeorm";
import { User } from "../Database/User";
import { Subject } from "../Database/Subject";
import { DatabaseError } from "../exceptions/DatabaseError";
import { AddedToSubjectEmail } from "../interfaces/emailInterfaces/AddedToSubjectEmail";
import { EmailError } from "../exceptions/EmailError";
import { UnverifiedUser } from "../Database/UnverifiedUser";
import { VerificationEmail } from "../interfaces/emailInterfaces/VerificationEmail";
import { EmailList } from "../interfaces/userInterfaces/SerivceModels";
import { AddUsersToSubjectRequest } from "../interfaces/userInterfaces/AddUsersToSubjectRequest";
import { validateEmails } from "../validations/emailValidate";
import { MockEmailService } from "../services/MockEmailService";

export class StudentService {
	emailService: EmailService;

	constructor() {
		this.emailService = new MockEmailService();
	}

	public async AddUsersToSubject(
		request: AddUsersToSubjectRequest
	): Promise<void> {
		let emails: string[] = request.users;

		if (validateEmails(emails)) {
			this.CategoriseUsersFromEmails(emails).then((list) => {
				this.HandleVerifiedUsers(list.verified, request.subject_id);
				this.HandleUnverifiedUsers(list.unverified, request.subject_id);
				this.HandleNonexistentUsers(
					list.nonexistent,
					request.subject_id
				);
			});
		}
	}

	private async HandleVerifiedUsers(
		emails: string[],
		id: number
	): Promise<void> {
		let subjectRepository = getRepository(Subject);
		let userRepository = getRepository(User);

		subjectRepository
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

				userRepository
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

						//TODO: Switch this to the subject repository
						subjectRepository.save(subject).then(() => {
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

	private async HandleUnverifiedUsers(
		emails: string[],
		id: number
	): Promise<void> {
		let subjectRepository = getRepository(Subject);
		let userRepository = getRepository(UnverifiedUser);

		subjectRepository
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

				userRepository
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

						subjectRepository.save(subject).then(() => {
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
	private async HandleNonexistentUsers(
		emails: string[],
		id: number
	): Promise<void> {
		let subjectRepository = getRepository(Subject);
		let userRepository = getRepository(UnverifiedUser);

		subjectRepository
			.findOne(id, {
				relations: ["unverifiedUsers"],
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

				userRepository.save(unverifiedUsers).then(() => {
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

	private async CategoriseUsersFromEmails(
		emails: string[]
	): Promise<EmailList> {
		let userRepository = getRepository(User);
		let unverifiedRepository = getRepository(UnverifiedUser);

		let list: EmailList = {
			verified: [],
			unverified: [],
			nonexistent: [],
		};

		return userRepository
			.find({ where: { email: In(emails) } })
			.then((users) => {
				list.verified = users.map((value) => value.email);
				let withoutVerified: string[] = emails.filter(
					(value) => !list.verified.includes(value)
				);

				return unverifiedRepository
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
