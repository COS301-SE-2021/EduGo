import { In, Repository } from "typeorm";
import { validateEmails } from "./validations/EmailValidate";
import { Subject } from "../Database/Subject";
import { UnverifiedUser } from "../Database/UnverifiedUser";
import { User } from "../Database/User";
import { EmailService } from "../helper/email/EmailService";
import { MockEmailService } from "../helper/email/MockEmailService";
import { AddedToSubjectEmail } from "../helper/email/models/AddedToSubjectEmail";
import { VerificationEmail } from "../helper/email/models/VerificationEmail";
import { AddStudentsToSubjectRequest } from "../models/user/AddStudentToSubjectRequest";
import { EmailList } from "../models/user/SerivceModels";
import { Service } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import { Student } from "../Database/Student";
import {
	GetStudentGradesResponse,
	QuizGrade,
} from "../models/user/GetStudentGradesResponse";
import { getUserDetails } from "../helper/auth/Userhelper";
import {
	BadRequestError,
	ForbiddenError,
	InternalServerError,
} from "routing-controllers";
import { Grade } from "../Database/Grade";
import { VirtualEntity } from "../Database/VirtualEntity";
import { Quiz } from "../Database/Quiz";
import { NodemailerService } from "../helper/email/NodemailerService";

/**
 * A class consisting of the functions that make up the student service
 * @class StudentService
 */
@Service()
export class StudentService {
	@InjectRepository(Subject) private subjectRepository: Repository<Subject>;
	@InjectRepository(User) private userRepository: Repository<User>;
	@InjectRepository(UnverifiedUser)
	private unverifiedUserRepository: Repository<UnverifiedUser>;
	@InjectRepository(Student) private studentRepository: Repository<Student>;
	@InjectRepository(Grade) private gradeRepository: Repository<Grade>;
	@InjectRepository(Quiz)
	private quizRepository: Repository<Quiz>;

	//TODO check error regarding mockEmailService injectable
	//@Inject('mailgunEmailService')
	emailService: EmailService = new NodemailerService();

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
	): Promise<String> {
		let emails: string[] = request.students;

		if (validateEmails(emails)) {
			let list = await this.CategoriseStudentsFromEmails(emails);
			this.HandleVerifiedStudents(list.verified, request.subject_id);
			this.HandleUnverifiedStudents(list.unverified, request.subject_id);
			this.HandleNonexistentStudents(
				list.nonexistent,
				request.subject_id
			);
			return "ok";
		} else throw new BadRequestError("Could not validate emails");
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
		let subject: Subject | undefined;

		try {
			subject = await this.subjectRepository.findOne(id, {
				relations: ["students", "students.user"],
			});
		} catch (error) {
			throw new BadRequestError("Could not find subject");
		}

		if (!subject) throw new BadRequestError("Subject could not be found");

		let allEnrolledUserEmails: string[] = subject.students.map(
			(value) => value.user.email
		);
		let nonEnrolledUserEmails: string[] = emails.filter(
			(value) => !allEnrolledUserEmails.includes(value)
		);

		let users = await this.userRepository.find({
			where: { email: In(nonEnrolledUserEmails) },
			relations: ["student"],
		});
		subject.students.push(...users.map((value) => value.student));
		let addedToSubjectEmails: AddedToSubjectEmail[] = users.map((value) => {
			return {
				email: value.email,
				name: value.firstName,
				subject: subject!.title,
			};
		});

		await this.subjectRepository.save(subject);
		let status = await this.emailService.SendBulkAddedToSubjectEmails(
			addedToSubjectEmails
		);
		if (!status)
			throw new InternalServerError(
				"Could not send added to subject emails"
			);
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
		let subject: Subject | undefined;

		subject = await this.subjectRepository.findOne(id, {
			relations: ["unverifiedUsers"],
		});
		if (!subject) throw new BadRequestError("Could not find subject");

		let allEnrolledUnverifiedEmails: string[] = subject.unverifiedUsers.map(
			(value) => value.email
		);

		let nonEnrolledUnverifiedEmails: string[] = emails.filter(
			(value) => !allEnrolledUnverifiedEmails.includes(value)
		);

		let users = await this.unverifiedUserRepository.find({
			where: { email: In(nonEnrolledUnverifiedEmails) },
		});
		let unverifiedEmails: VerificationEmail[] = users.map((value) => {
			return {
				code: value.verificationCode,
				email: value.email,
			};
		});
		subject.unverifiedUsers.push(...users);

		await this.subjectRepository.save(subject);
		let status = await this.emailService.SendBulkVerificationReminderEmails(
			unverifiedEmails
		);
		if (!status)
			throw new InternalServerError("Could not send reminder emails");
	}

	//Precondition: all the emails given are already known to NOT exists, so checking if they
	//exist is unnecessary
	private async HandleNonexistentStudents(
		emails: string[],
		id: number
	): Promise<void> {
		let subject: Subject | undefined;
		subject = await this.subjectRepository.findOne(id, {
			relations: ["unverifiedUsers", "organisation"],
		});
		if (!subject) throw new BadRequestError("Could not find subject");

		let unverifiedUsers: UnverifiedUser[] = emails.map((value) => {
			let user: UnverifiedUser = new UnverifiedUser();
			user.email = value;
			user.verificationCode = this.generateCode(5);
			user.organisation = subject!.organisation;
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

		await this.unverifiedUserRepository.save(unverifiedUsers);
		let status = await this.emailService.SendBulkVerificationEmails(
			unverifiedEmails
		);
		if (!status) throw new InternalServerError("Could not send all emails");
	}

	private async CategoriseStudentsFromEmails(
		emails: string[]
	): Promise<EmailList> {
		let list: EmailList = {
			verified: [],
			unverified: [],
			nonexistent: [],
		};

		let users = await this.userRepository.find({
			where: { email: In(emails) },
		});
		list.verified = users.map((value) => value.email);
		let withoutVerified: string[] = emails.filter(
			(value) => !list.verified.includes(value)
		);

		let unverifiedUsers = await this.unverifiedUserRepository.find({
			where: { email: In(withoutVerified) },
		});
		list.unverified = unverifiedUsers.map((value) => value.email);
		list.nonexistent = withoutVerified.filter(
			(value) => !list.unverified.includes(value)
		);

		return list;
	}

	private generateCode(length: number): string {
		let charset = "0123456789";
		let result = "";
		for (let i = 0; i < length; i++)
			result += charset[Math.floor(Math.random() * charset.length)];
		return result;
	}

	public async GetStudentGrades(
		user_id: number
	): Promise<GetStudentGradesResponse> {
		let user: User;

		try {
			user = await getUserDetails(user_id);
		} catch (err) {
			throw err;
		}

		if (user.student) {
			try {
				let student = await this.studentRepository.findOne(
					user.student.id,
					{ relations: ["grades"] }
				);

				if (student) {
					let quizGrades = await Promise.all(
						student.grades.map(async (grade) => {
							let quizGrade = {
								name: "",
								students_score: 0,
								quiz_total: 0,
								VirtualEntityId: 0,
							};
							let gradeInfo = await this.getGradeInfo(grade.id);

							if (gradeInfo) {
								quizGrade.students_score = gradeInfo.score;
								quizGrade.quiz_total = gradeInfo.total;

								quizGrade.VirtualEntityId =
									await this.getvirtualEntityId(
										gradeInfo.quiz.id
									);
								return await quizGrade;
							}
						})
					);

					let StudentGrades: GetStudentGradesResponse = {
						quiz_grades: quizGrades,
					};
					return StudentGrades;
				} else throw new BadRequestError("Could not find student");
			} catch (err) {
				throw err;
			}
		}
		throw new ForbiddenError("Only student grades can be displayed"); //Supposed to be a 403
	}

	async getUserSubjects() {}
	async getGradeInfo(grade_id: number) {
		try {
			let Quiz = await this.gradeRepository.findOne(grade_id, {
				relations: ["quiz"],
			});
			if (Quiz) {
				return Quiz;
			} else return undefined;
		} catch (err) {
			throw new InternalServerError(err);
		}
	}

	async getvirtualEntityId(quiz_id: number) {
		try {
			let quiz = await this.quizRepository.findOne(quiz_id, {
				relations: ["virtualEntity"],
			});

			if (quiz) {
				return quiz.virtualEntity.id;
			}
			return 0;
		} catch (err) {
			throw new InternalServerError(err);
		}
	}
}
