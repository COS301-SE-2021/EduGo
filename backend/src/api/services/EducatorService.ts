import { In, Repository, SimpleConsoleLogger } from "typeorm";
import { validateEmails } from "./validations/EmailValidate";
import { Organisation } from "../database/Organisation";
import { UnverifiedUser } from "../database/UnverifiedUser";
import { EmailService } from "../helper/email/EmailService";
import { MockEmailService } from "../helper/email/MockEmailService";
import { VerificationEmail } from "../helper/email/models/VerificationEmail";
import { AddEducatorsRequest } from "../models/user/AddEducatorsRequest";
import { EmailList } from "../models/user/SerivceModels";
import { User } from "../database/User";
import { getUserDetails } from "../helper/auth/Userhelper";
import { AddEducatorToExistingSubjectRequest } from "../models/user/AddEducatorToExistingSubjectRequest";
import { Subject } from "../database/Subject";
import { Service, Inject } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import {
	BadRequestError,
	InternalServerError,
	NotFoundError,
} from "routing-controllers";
import { NodemailerService } from "../helper/email/NodemailerService";
import { Educator } from "../database/Educator";
import { anyFunction } from "ts-mockito";
import { GetStudentGradesResponse } from "../models/user/GetStudentGradesResponse";
import { Grade } from "../database/Grade";
import {
	GetGradesByEducatorResponse,
	StudentG,
	SubjectGrade,
} from "../models/user/GetGradesByEducatorResponse";

/**
 * A class consisting of the functions that make up the educator service
 * @class EducatorService
 */
@Service()
export class EducatorService {
	@InjectRepository(Subject) private subjectRepository: Repository<Subject>;
	@InjectRepository(User) private userRepository: Repository<User>;
	@InjectRepository(Organisation)
	private organisationRepository: Repository<Organisation>;
	@InjectRepository(UnverifiedUser)
	private unverifiedUserRepository: Repository<UnverifiedUser>;
	@InjectRepository(Educator)
	private educatorRepository: Repository<Educator>;

	//TODO check error regarding mockEmailService injectable
	// @Inject("mailgunemailservice")
	emailService: EmailService = new NodemailerService();

	/**
	 * @param  {AddEducatorToExistingSubjectRequest} body
	 * @param  {number} user_id
	 * @returns Promise
	 */
	async AddEducatorToExistingSubject(
		body: AddEducatorToExistingSubjectRequest,
		user_id: number
	): Promise<string> {
		let adminDetails: User;
		let subjectDetails: Subject | undefined;
		let educatorDetails: User | undefined;
		try {
			adminDetails = await getUserDetails(user_id);
		} catch (error) {
			throw error;
		}

		try {
			educatorDetails = await this.userRepository.findOne({
				username: body.username,
			});
		} catch (error) {
			throw new NotFoundError("Educator not found");
		}

		try {
			subjectDetails = await this.subjectRepository.findOne(
				body.subject_id,
				{ relations: ["user"] }
			);
		} catch (error) {
			throw new NotFoundError("Subject not found");
		}

		if (adminDetails && educatorDetails && subjectDetails) {
			if (
				adminDetails.organisation.id == educatorDetails.organisation.id
			) {
				if (educatorDetails.educator != undefined) {
					educatorDetails.educator.subjects.push(subjectDetails);
					return "ok";
				} else throw new BadRequestError("User is not an educator");
			} else
				throw new BadRequestError(
					"Admin doesn't belong to same organisation as educator"
				);
		} else
			throw new InternalServerError(
				"Could not determine admin, educator or subject"
			);
	}

	/**
	 * @param {AddEducatorsRequest} request - A request consisting of the organisation id and an array of email strings
	 * @param {string[]} request.emails - An array of educator email addresses (unvalidated)
	 * @param {number} request.organisation_id - The id of the organisation the educators are added to
	 * @throws {DatabaseError} Could not find organisation in database from the specified id
	 * @returns {Promise<void>}
	 * @description Add educators to a specified organisation. Educators will be added using their personnel email addresses.
	 * 1. The emails will be validated {@see validateEmails}
	 * 2. The organisation will be searched for (with the user and unverified user relations) and ensured that it is defined
	 * 3. A categorised list will be created from the emails {@see CategoriseEducatorsFromEmails}
	 * 4. The appropriate handlers will be called based on the categories
	 */
	public async AddEducators(
		request: AddEducatorsRequest,
		user_id: number
	): Promise<string> {
		const emails: string[] = request.educators;

		if (validateEmails(emails)) {
			let user: User | undefined;
			try {
				user = await this.userRepository.findOne({
					where: { id: user_id },
					relations: [
						"organisation",
						"organisation.users",
						"organisation.unverifiedUsers",
					],
				});
			} catch (err) {
				throw new NotFoundError("User not found");
			}

			if (user && user.organisation) {
				const org = user.organisation;
				const list = this.CategoriseEducatorsFromEmails(emails, org);
				this.HandleNonExistentEducators(list.nonexistent, org);
				this.HandleUnverifiedEducators(list.unverified);
				return "ok";
			} else
				throw new InternalServerError(
					"Could not determine organisation"
				);
		} else throw new BadRequestError("Could not validate emails");
	}

	/**
	 * @param {string[]} emails - An array of emails of unverified educators
	 * @throws {EmailError} Not all of the emails could be sent
	 * @description Will receive the already categorized unverified email addresses and:
	 * 1. Find all the UnverifiedUser objects for each email
	 * 2. Create VerificationEmail objects from each UnverifiedUser
	 * 3. Send the emails by invoking the SendBulkVerificationReminderEmails function from the email service
	 */
	private async HandleUnverifiedEducators(emails: string[]) {
		let users: UnverifiedUser[];
		try {
			users = await this.unverifiedUserRepository.find({
				where: { email: In(emails) },
			});
		} catch (err) {
			throw new InternalServerError("Could not find unverified users");
		}

		const reminderEmails: VerificationEmail[] = users
			.filter((value) => value)
			.map((value) => {
				return {
					email: value.email,
					code: value.verificationCode,
				};
			});

		const status =
			await this.emailService.SendBulkVerificationReminderEmails(
				reminderEmails
			);
		if (!status)
			throw new InternalServerError("Could not send all reminder emails");
	}

	/**
	 * @param {string[]} emails - An array of email address of unregistered educators
	 * @param {Organisation} org - An object detailing the current organisation, includes the unverifiedUsers relation
	 * @throws {EmailError} Not all of the emails could be sent
	 * @description Will receive the already categorised unregistered email addresses and do the following:
	 * 1. Create new UnverifiedUser instances from each email address in emails
	 * 2. Generate a new and random code for each UnverifiedUser object (length: 5)
	 * 3. Create VerificationEmail objects from each of the newly creted UnverifiedUser objects
	 * 4. Save the new users to the Unverified User repository
	 * 5. Send the emails by invoking the SendBulkVerificationEmails function from the email service
	 */
	private async HandleNonExistentEducators(
		emails: string[],
		org: Organisation
	) {
		const users: UnverifiedUser[] = emails.map((value) => {
			const user: UnverifiedUser = new UnverifiedUser();
			user.email = value;
			user.type = "educator";
			user.subjects = [];
			//TODO move generate code function to Helper file
			user.verificationCode = this.generateCode(5);
			user.organisation = org;
			return user;
		});

		const unverifiedEmails: VerificationEmail[] = users.map((value) => {
			return { code: value.verificationCode, email: value.email };
		});

		await this.unverifiedUserRepository.save(users);
		const status = await this.emailService.SendBulkVerificationEmails(
			unverifiedEmails
		);
		if (!status)
			throw new InternalServerError(
				"Could not send all verification emails"
			);
	}

	/**
	 * @param {string[]} emails - An unsorted/uncategorised/unvalidated/unverified array of email addresses of educators
	 * @param {Organisation} org - An object detailing the current organisation, includes the unverifiedUsers relation
	 * @returns {EmailList} - An object containing 3 string arrays
	 * @description Will receive an array of educator email addresses and through filtering and comparison from the
	 * organisations users and unverified users, will group the email addresses by nonexistent and unverified
	 * 1. Get a list of all the unverified user emails (this is the 'ALL' list)
	 * 2. Get all the emails of educators within that the organisation (this is the 'EDU' list)
	 * 3. Categorise the unverified emails by checking which ones are in the 'ALL' list and saving those
	 * 4. Get the nonexistent emails by checking which emails DO NOT occur in the 'EDU' list
	 * 5. Return the compiled list
	 */
	private CategoriseEducatorsFromEmails(
		emails: string[],
		org: Organisation
	): EmailList {
		const list: EmailList = {
			verified: [],
			unverified: [],
			nonexistent: [],
		};
		const allUnverifiedUserEmails: string[] = org.unverifiedUsers.map(
			(value) => value.email
		);
		const allVerifiedUserEmails: string[] = org.users
			.filter((value) => value.educator)
			.map((value) => value.email);

		list.unverified = emails.filter((value) =>
			allUnverifiedUserEmails.includes(value)
		);
		list.nonexistent = emails
			.filter((value) => !list.unverified.includes(value))
			.filter((value) => !allVerifiedUserEmails.includes(value));

		return list;
	}

	public async getStudentGrades(userId: number) {
		let user: User;
		try {
			const dUser = await this.userRepository.findOne(userId, {
				relations: [
					"educator",
					"educator.subjects",
					"educator.subjects.students",
					"educator.subjects.students.user",
					"educator.subjects.students.grades",
					"educator.subjects.students.grades.subject",
				],
			});
			if (!dUser) throw new NotFoundError("User not found");
			user = dUser;
		} catch (err) {
			throw new InternalServerError(
				"There was an error finding the user"
			);
		}

		interface response {
			allGrades: any;
		}

		const educatorGrades: GetGradesByEducatorResponse = { subjects: [] };

		educatorGrades.subjects = user.educator.subjects.map((sub) => {
			const subjectG: SubjectGrade = {
				subjectName: sub.title,
				students: sub.students.map((student) => {
					console.log(student.grades);
					const grades = student.grades.filter(
						(grad) => grad.subject.id == sub.id
					);
					const studentData: StudentG = {
						username: student.user.username,
						firstname: student.user.firstName,
						lastname: student.user.lastName,
						studentgrade: this.generateSubjectTotal(grades),
					};

					return studentData;
				}),
			};

			return subjectG;
		});

		return educatorGrades;
	}

	private generateSubjectTotal(grades: Grade[]) {
		let score = 0;
		let total = 0;

		grades.map((grade) => {
			score += grade.score;
			total += grade.total;
		});

		return (score / total) * 100;
	}

	/**
	 * @param {number} length - Integer value of the length of the returned string
	 * @returns {string} Randomly generated string of numerical digits
	 * @description Will generate a string of random numerical digits from the charset variable.
	 * Length will be determined from the length parameter
	 */
	private generateCode(length: number): string {
		const charset = "0123456789";
		let result = "";
		for (let i = 0; i < length; i++)
			result += charset[Math.floor(Math.random() * charset.length)];
		return result;
	}
}
