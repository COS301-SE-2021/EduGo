import { In, Repository } from "typeorm";
import { validateEmails } from "./validations/EmailValidate";
import { Subject } from "../database/Subject";
import { UnverifiedUser } from "../database/UnverifiedUser";
import { User } from "../database/User";
import { EmailService } from "../helper/email/EmailService";
import { AddedToSubjectEmail } from "../helper/email/models/AddedToSubjectEmail";
import { VerificationEmail } from "../helper/email/models/VerificationEmail";
import { AddStudentsToSubjectRequest } from "../models/user/AddStudentToSubjectRequest";
import { EmailList } from "../models/user/SerivceModels";
import { Inject, Service } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import { Student } from "../database/Student";
import {
	GetStudentGradesResponse,
	LessonGrades,
	QuizGrade,
	SubjectGrades,
} from "../models/user/GetStudentGradesResponse";
import {
	BadRequestError,
	InternalServerError,
	NotFoundError,
} from "routing-controllers";
import { Grade } from "../database/Grade";
import { Quiz } from "../database/Quiz";
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
	@InjectRepository(Quiz) private quizRepository: Repository<Quiz>;

	//TODO check error regarding mockEmailService injectable
	@Inject()
	emailService: NodemailerService = new NodemailerService();

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
	): Promise<string> {
		const emails: string[] = request.students;
		try {
			if (validateEmails(emails)) {
				const list = await this.CategoriseStudentsFromEmails(emails);
				this.HandleVerifiedStudents(list.verified, request.subject_id);
				this.HandleUnverifiedStudents(
					list.unverified,
					request.subject_id
				);
				this.HandleNonexistentStudents(
					list.nonexistent,
					request.subject_id
				);
				return "ok";
			} else throw new BadRequestError("Could not validate emails");
		} catch (err) {
			throw err;
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
		let subject: Subject | undefined;

		try {
			subject = await this.subjectRepository.findOne(id, {
				relations: ["students", "students.user"],
			});
			if (!subject) throw new NotFoundError("Subject could not be found");
		} catch (error) {
			return;
		}

		const allEnrolledUserEmails: string[] = subject.students.map(
			(value) => value.user.email
		);
		const nonEnrolledUserEmails: string[] = emails.filter(
			(value) => !allEnrolledUserEmails.includes(value)
		);

		const users = await this.userRepository.find({
			where: { email: In(nonEnrolledUserEmails) },
			relations: ["student"],
		});
		subject.students.push(...users.map((value) => value.student));
		const addedToSubjectEmails: AddedToSubjectEmail[] = users.map(
			(value) => {
				return {
					email: value.email,
					name: value.firstName,
					subject: subject!.title,
				};
			}
		);

		await this.subjectRepository.save(subject);
		const status = await this.emailService.SendBulkAddedToSubjectEmails(
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
		try {
			subject = await this.subjectRepository.findOne(id, {
				relations: ["unverifiedUsers"],
			});
			if (!subject) throw new BadRequestError("Could not find subject");
		} catch (err) {
			return;
		}

		const allEnrolledUnverifiedEmails: string[] =
			subject.unverifiedUsers.map((value) => value.email);

		const nonEnrolledUnverifiedEmails: string[] = emails.filter(
			(value) => !allEnrolledUnverifiedEmails.includes(value)
		);

		const users = await this.unverifiedUserRepository.find({
			where: { email: In(nonEnrolledUnverifiedEmails) },
		});
		const unverifiedEmails: VerificationEmail[] = users.map((value) => {
			return {
				code: value.verificationCode,
				email: value.email,
			};
		});
		subject.unverifiedUsers.push(...users);

		await this.subjectRepository.save(subject);
		const status =
			await this.emailService.SendBulkVerificationReminderEmails(
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

		try {
			subject = await this.subjectRepository.findOne(id, {
				relations: ["unverifiedUsers", "organisation"],
			});
			if (!subject) throw new BadRequestError("Could not find subject");
		} catch (err) {
			return;
		}

		const unverifiedUsers: UnverifiedUser[] = emails.map((value) => {
			const user: UnverifiedUser = new UnverifiedUser();
			user.email = value;
			user.verificationCode = this.generateCode(5);
			user.organisation = subject!.organisation;
			user.subjects = [subject!];
			user.type = "student";
			return user;
		});

		const unverifiedEmails: VerificationEmail[] = unverifiedUsers.map(
			(value) => {
				return {
					code: value.verificationCode,
					email: value.email,
				};
			}
		);

		await this.unverifiedUserRepository.save(unverifiedUsers);
		const status = await this.emailService.SendBulkVerificationEmails(
			unverifiedEmails
		);
		if (!status) throw new InternalServerError("Could not send all emails");
	}

	private async CategoriseStudentsFromEmails(
		emails: string[]
	): Promise<EmailList> {
		const list: EmailList = {
			verified: [],
			unverified: [],
			nonexistent: [],
		};

		const users = await this.userRepository.find({
			where: { email: In(emails) },
		});
		list.verified = users.map((value) => value.email);
		const withoutVerified: string[] = emails.filter(
			(value) => !list.verified.includes(value)
		);

		const unverifiedUsers = await this.unverifiedUserRepository.find({
			where: { email: In(withoutVerified) },
		});
		list.unverified = unverifiedUsers.map((value) => value.email);
		list.nonexistent = withoutVerified.filter(
			(value) => !list.unverified.includes(value)
		);

		return list;
	}

	private generateCode(length: number): string {
		const charset = "0123456789";
		let result = "";
		for (let i = 0; i < length; i++)
			result += charset[Math.floor(Math.random() * charset.length)];
		return result;
	}

	/**
	 * @description Get all the student grades including the ones that are not yet
	 * 					completed
	 * @param {number} id - The user id of the student
	 * @returns {Promise<GetStudentGradesResponse>} The grades of the student
	 */
	public async GetStudentGrades(
		id: number
	): Promise<GetStudentGradesResponse> {
		let user: User | undefined;
		try {
			user = await this.userRepository.findOne({
				where: { id: id },
				relations: [
					"student",
					"student.subjects",
					"student.grades",
					"student.grades.quiz",
					"student.grades.lesson",
					"student.grades.lesson.subject",
				],
			});
		} catch (err) {}

		if (!user) throw new BadRequestError("Could not find user");
		if (!user.student) throw new BadRequestError("Could not find student");

		const response: GetStudentGradesResponse = {
			subjects: [],
		};

		//For each grade
		user.student.grades.map((value) => {
			//Get the subject name
			const subjectName: string = value.lesson.subject.title;

			//Search for the corresponding SubjectGrades object in the response object
			let subject: SubjectGrades | undefined = response.subjects.find(
				(sub) => sub.subjectName === subjectName
			);

			//If the SubjectGrades object does not exist, create one and store it in the response object then push to the response object
			if (!subject) {
				subject = {
					id: value.lesson.subject.id,
					subjectName: subjectName,
					gradeAchieved: 0,
					lessonGrades: [],
				};
				response.subjects.push(subject);
			}

			//Get the lesson name
			const lessonName: string = value.lesson.title;

			//Search for the corresponding LessonGrades object in the current subject object
			let lesson: LessonGrades | undefined = subject.lessonGrades.find(
				(sub) => sub.lessonName === lessonName
			);

			//If the LessonGrades object does not exist, create one and store it in the current subject object then push to the current subject object
			if (!lesson) {
				lesson = {
					id: value.lesson.id,
					lessonName: lessonName,
					gradeAchieved: 0,
					quizGrades: [],
				};
				subject.lessonGrades.push(lesson);
			}

			//Create the quiz grade object and push it to the current lesson object
			const grade: QuizGrade = {
				name: "",
				quiz_total: value.total,
				student_score: value.score,
			};
			lesson.quizGrades.push(grade);
			lesson.gradeAchieved += (value.score / value.total) * 100;
		});

		//Get all the subjects that have grades for the user then get the remaining user subjects that do not have grades
		const existingSubjectIds: number[] = response.subjects.map(
			(sub) => sub.id
		);
		const remainingSubjects: Subject[] = user.student.subjects.filter(
			(sub) => !existingSubjectIds.includes(sub.id)
		);

		//calculate the running total fot the lessons
		response.subjects = response.subjects.map((sub) => {
			sub.lessonGrades = sub.lessonGrades.map((les) => {
				les.gradeAchieved = les.gradeAchieved / les.quizGrades.length;
				sub.gradeAchieved += les.gradeAchieved;

				return les;
			});
			sub.gradeAchieved = sub.gradeAchieved / sub.lessonGrades.length;
			return sub;
		});
		//For each remaining subject create a new SubjectGrades object and push it to the response object
		remainingSubjects.map((sub) => {
			const subject: SubjectGrades = {
				id: sub.id,
				subjectName: sub.title,
				gradeAchieved: 0,
				lessonGrades: [],
			};
			response.subjects.push(subject);
		});
		return response;
	}
	async getGradeInfo(grade_id: number) {
		try {
			const Quiz = await this.gradeRepository.findOne(grade_id, {
				relations: ["quiz", "lesson"],
			});
			if (Quiz) {
				return Quiz;
			} else throw new NotFoundError("Quiz not found");
		} catch (err) {
			console.log(err);
			throw new InternalServerError(
				`Could not find grade id: ${grade_id}`
			);
		}
	}

	async getvirtualEntityId(quiz_id: number) {
		try {
			const quiz = await this.quizRepository.findOne(quiz_id, {
				relations: ["virtualEntity"],
			});

			if (quiz) {
				return quiz.virtualEntity.id;
			}
			return 0;
		} catch (err) {
			console.log(err);
			throw new InternalServerError(
				`Could not finnd quiz id: ${quiz_id}`
			);
		}
	}
	/**
	 * @description Get all the grades for a student (including grades from lessons without any marks)
	 * @param {Student} student - Database Student entity
	 * @returns {Promise<GetStudentGradesResponse>}
	 */
	async populateGrades(student: Student): Promise<GetStudentGradesResponse> {
		console.log(student);

		const studentSubjects = student.subjects.map((subject) => {
			const createdSubject: SubjectGrades = {
				id: subject.id,
				subjectName: subject.title,
				gradeAchieved: -1,
				lessonGrades: [],
			};
			return createdSubject;
		});

		console.log(studentSubjects);
		const ids = studentSubjects.map((subject) => subject.id);
		const subjects: Subject[] = await this.subjectRepository.find({
			where: { id: In(ids) },
			relations: ["lessons"],
		});
		studentSubjects.map(async (subject) => {
			const subjectLesson = subjects.find((sub) => sub.id == subject.id);
			if (!subjectLesson) throw new NotFoundError("Subject not found");

			subject.lessonGrades = subjectLesson.lessons.map((lesson) => {
				return {
					id: lesson.id,
					gradeAchieved: -1,
					lessonName: lesson.title,
					quizGrades: [],
				};
			});
		});
		const StudentGrades: GetStudentGradesResponse = {
			subjects: studentSubjects,
		};

		return StudentGrades;
	}
}
