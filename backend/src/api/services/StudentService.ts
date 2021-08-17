import { In, Repository } from "typeorm";
import { validateEmails } from "./validations/EmailValidate";
import { Subject } from "../database/Subject";
import { UnverifiedUser } from "../database/UnverifiedUser";
import { User } from "../database/User";
import { EmailService } from "../helper/email/EmailService";
import { MockEmailService } from "../helper/email/MockEmailService";
import { AddedToSubjectEmail } from "../helper/email/models/AddedToSubjectEmail";
import { VerificationEmail } from "../helper/email/models/VerificationEmail";
import { AddStudentsToSubjectRequest } from "../models/user/AddStudentToSubjectRequest";
import { EmailList } from "../models/user/SerivceModels";
import { Service } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import { Student } from "../database/Student";
import {
	GetStudentGradesResponse,
	LessonGrades,
	QuizGrade,
	SubjectGrades,
} from "../models/user/GetStudentGradesResponse";
import { getUserDetails } from "../helper/auth/Userhelper";
import {
	BadRequestError,
	ForbiddenError,
	InternalServerError,
	NotFoundError,
} from "routing-controllers";
import { Grade } from "../database/Grade";
import { VirtualEntity } from "../database/VirtualEntity";
import { Quiz } from "../database/Quiz";
import { NodemailerService } from "../helper/email/NodemailerService";
import { lchmod } from "fs";

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
			user.subjects = [subject!];
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

	public async GetStudentGrades(id: number): Promise<GetStudentGradesResponse> {
		let user: User | undefined;
		try {
			user = await this.userRepository.findOne({where: {id: id}, relations: ["student", "student.grades", "student.grades.quiz", "student.grades.lesson", "student.grades.lesson.subject"]});
		}
		catch (err) {
			throw new BadRequestError("Could not find user");
		}

		if (!user) throw new BadRequestError("Could not find user");
		if (!user.student) throw new BadRequestError("Could not find student");

		let response: GetStudentGradesResponse = {
			subjects: []
		}

		//For each grade
		user.student.grades.map(value => {
			//Get the subject name
			let subjectName: string = value.lesson.subject.title;
			
			//Search for the corresponding SubjectGrades object in the response object
			let subject: SubjectGrades | undefined = response.subjects.find(sub => sub.subjectName === subjectName);

			//If the SubjectGrades object does not exist, create one and store it in the response object then push to the response object
			if (!subject) {
				subject = {
					id: value.lesson.subject.id,
					subjectName: subjectName,
					gradeAchieved: 0,
					lessonGrades: []
				}
				response.subjects.push(subject);
			}

			//Get the lesson name
			let lessonName: string = value.lesson.title;

			//Search for the corresponding LessonGrades object in the current subject object
			let lesson: LessonGrades | undefined = subject.lessonGrades.find(sub => sub.lessonName === lessonName);

			//If the LessonGrades object does not exist, create one and store it in the current subject object then push to the current subject object
			if (!lesson) {
				lesson = {
					id: value.lesson.id,
					lessonName: lessonName,
					gradeAchieved: 0,
					quizGrades: []
				}
				subject.lessonGrades.push(lesson);
			}

			//Create the quiz grade object and push it to the current lesson object
			let grade: QuizGrade = {
				name: "",
				quiz_total: value.total,
				student_score: value.score,
			}
			lesson.quizGrades.push(grade);
			lesson.gradeAchieved += value.score;
			subject.gradeAchieved += value.score;
			
		});
		return response;
	}


	// public async GetStudentGrades(
	// 	user_id: number
	// ): Promise<GetStudentGradesResponse> {
	// 	let user: User;
	// 	try {
	// 		user = await getUserDetails(user_id);
	// 	} catch (err) {
	// 		throw err;
	// 	}
	// 	if (!user.student) throw new ForbiddenError("Only student grades can be displayed");

	// 	try {
	// 		let student = await this.studentRepository.findOne(
	// 			user.student.id,
	// 			{ relations: ["grades", "subjects"] }
	// 		);
	// 		if (!student) throw new BadRequestError("Could not find student");

	// 		let studentGrade = await this.populateGrades(student);
	// 		let quizGrades = await Promise.all(
	// 			student.grades.map(async (grade) => {
	// 				let quizGrade = {
	// 					name: "",
	// 					students_score: 0,
	// 					quiz_total: 0,
	// 					VirtualEntityId: 0,
	// 					lessonId: 0,
	// 				};
	// 				let gradeInfo = await this.getGradeInfo(grade.id);

	// 				if (gradeInfo) {
	// 					quizGrade.students_score = gradeInfo.score;
	// 					quizGrade.quiz_total = gradeInfo.total;
	// 					quizGrade.lessonId = gradeInfo.lesson?.id;
	// 					quizGrade.VirtualEntityId =
	// 						await this.getvirtualEntityId(
	// 							gradeInfo.quiz.id
	// 						);
	// 					return await quizGrade;
	// 				}
	// 			})
	// 		);
	// 		console.log(studentGrade);
	// 		if(!studentGrade.subjects) throw new NotFoundError("blank not created")

	// 		studentGrade.subjects = studentGrade.subjects.map(
	// 			(subject) => {
	// 				let subjectG = subject.lessonGrades.map(
	// 					(lesson) => {
	// 						let lessonG = quizGrades.map((quizMark) => {
	// 							if (quizMark?.lessonId == lesson.id) {
	// 								let quizes = quizGrades.map(
	// 									(quiz) => {
	// 										let quizer: QuizGrade={};
	// 										if (quiz && quizMark) {
	// 											quizer.name = quiz.name;
	// 											quizer.student_score = quiz.students_score;
	// 											quizer.quiz_total = quiz.quiz_total;
	// 										}
	// 										return quizer;
	// 									}
	// 								);

	// 								lesson.quizGrades = quizes;
	// 							}
	// 							return lesson;
	// 						});
	// 						subject.lessonGrades = lessonG;
	// 						return subject;
	// 					}
	// 				);
	// 				return subject;
	// 			}
	// 		);
	// 		return studentGrade;
	// 	} catch (err) {
	// 		throw err;
	// 	}
	// }

	async getUserSubjects() {}
	async getGradeInfo(grade_id: number) {
		try {
			let Quiz = await this.gradeRepository.findOne(grade_id, {
				relations: ["quiz", "lesson"],
			});
			if (Quiz) {
				return Quiz;
			} else throw new NotFoundError("Quiz not found");
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
	/**
	 * @description Get all the grades for a student (including grades from lessons without any marks)
	 * @param {Student} student - Database Student entity
	 * @returns {Promise<GetStudentGradesResponse>}
	 */
	async populateGrades(student: Student): Promise<GetStudentGradesResponse> {
		console.log(student);

		let studentSubjects = student.subjects.map((subject) => {
			let createdSubject: SubjectGrades = {
				id: subject.id,
				subjectName: subject.title,
				gradeAchieved: -1,
				lessonGrades: [],
			};
			return createdSubject;
		});

		console.log(studentSubjects);
		let ids = studentSubjects.map((subject) => subject.id);
		let subjects: Subject[] = await this.subjectRepository.find({
			where: { id: In(ids) },
			relations: ["lessons"],
		});
		studentSubjects.map(async (subject) => {
			let subjectLesson = subjects.find((sub) => sub.id == subject.id);
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
		let StudentGrades: GetStudentGradesResponse = {
			subjects: studentSubjects,
		};

		return StudentGrades;
	}
	async GenerateAverages(studentGrade: GetStudentGradesResponse) {}
}
