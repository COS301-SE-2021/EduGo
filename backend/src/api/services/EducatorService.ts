import { getRepository, In } from "typeorm";
import { validateEmails } from "./validations/EmailValidate";
import { Organisation } from "../database/Organisation";
import { UnverifiedUser } from "../database/UnverifiedUser";
import { DatabaseError } from "../errors/DatabaseError";
import { EmailError } from "../errors/EmailError";
import { EmailService } from "../helper/email/EmailService";
import { MockEmailService } from "../helper/email/MockEmailService";
import { VerificationEmail } from "../helper/email/models/VerificationEmail";
import { AddEducatorsRequest } from "../models/user/AddEducatorsRequest";
import { EmailList } from "../models/user/SerivceModels";
import { User } from "../database/User";
import { getUserDetails } from "../helper/auth/Userhelper";
import { NonExistantItemError } from "../errors/NonExistantItemError";
import { AddEducatorToExistingSubjectRequest } from "../models/user/AddEducatorToExistingSubjectRequest";
import { Error400 } from "../errors/Error";
import { Subject } from "../database/Subject";
import { Service } from "typedi";


/**
 * A class consisting of the functions that make up the educator service
 * @class EducatorService
 */
@Service()
export class EducatorService {
	emailService: EmailService;

	/**
	 * Create an educator service
	 */
	constructor() {
		this.emailService = new MockEmailService();
	}

	/**
	 * @param  {AddEducatorToExistingSubjectRequest} body
	 * @param  {number} user_id
	 * @returns Promise
	 */
	async addEducatorToExistingSubject(
		body: AddEducatorToExistingSubjectRequest,
		user_id: number
	): Promise<void> {
		let adminDetails: User;
		let subjectDetails: Subject | undefined;
		let educatorDetails: User | undefined;
		try {
			adminDetails = await getUserDetails(user_id);
		} catch (error) {
			throw error;
		}

		try {
			educatorDetails = await getRepository(User).findOne({
				where: { username: body.username },
			});
		} catch (error) {
			throw new NonExistantItemError("User with not found");
		}

		try {
			subjectDetails = await getRepository(Subject).findOne(
				body.subject_id,
				{ relations: ["user"] }
			);
		} catch (error) {
			throw new NonExistantItemError("subject with not found");
		}

		if (adminDetails && educatorDetails && subjectDetails) {
			if (
				adminDetails.organisation.id == educatorDetails.organisation.id
			) {
				if (educatorDetails.educator != undefined) {
					educatorDetails.educator.subjects.push(subjectDetails);
					return;
				} else throw new Error400("User is not an educator");
			} else
				throw new Error400(
					"Admin doesn't belong to same organisation as educator"
				);
		}
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
	): Promise<void> {
		let emails: string[] = request.educators;
		let organisationRepository = getRepository(Organisation);

		let user: User;
		try {
			user = await getUserDetails(user_id);
		} catch (error) {
			throw error;
		}

		if (user && user.organisation && validateEmails(emails)) {
			organisationRepository
				.findOne(user.organisation.id, {
					relations: ["users", "unverifiedUsers"],
				})
				.then((org) => {
					if (!org)
						throw new DatabaseError("Could not find organisation");

					let list = this.CategoriseEducatorsFromEmails(emails, org);
					this.HandleNonExistentEducators(list.nonexistent, org);
					this.HandleUnverifiedEducators(list.unverified);
				});
		} else {
			throw new NonExistantItemError("Organisation not existant");
		}
	}

	/**
	 * @param {string[]} emails - An array of emails of unverified educators
	 * @throws {EmailError} Not all of the emails could be sent
	 * @description Will receive the already categorised unverified email addresses and:
	 * 1. Find all the UnverifiedUser objects for each email
	 * 2. Create VerificationEmail objects from each UnverifiedUser
	 * 3. Send the emails by invoking the SendBulkVerificationReminderEmails function from the email service
	 */
	private async HandleUnverifiedEducators(emails: string[]) {
		getRepository(UnverifiedUser)
			.find({ where: { email: In(emails) } })
			.then((users) => {
				let reminderEmails: VerificationEmail[] = users
					.filter((value) => value)
					.map((value) => {
						return {
							email: value.email,
							code: value.verificationCode,
						};
					});

				this.emailService
					.SendBulkVerificationReminderEmails(reminderEmails)
					.then((result) => {
						if (!result)
							throw new EmailError("Could not send all emails");
					});
			});
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
		let users: UnverifiedUser[] = emails.map((value) => {
			let user: UnverifiedUser = new UnverifiedUser();
			user.email = value;
			user.type = "educator";
			user.subjects = [];
			//TODO move generate code function to Helper file
			user.verificationCode = this.generateCode(5);
			user.organisation = org;
			return user;
		});

		let unverifiedEmails: VerificationEmail[] = users.map((value) => {
			return { code: value.verificationCode, email: value.email };
		});
		getRepository(UnverifiedUser)
			.save(users)
			.then(() => {
				this.emailService
					.SendBulkVerificationEmails(unverifiedEmails)
					.then((result) => {
						if (!result)
							throw new EmailError("Could not send all emails");
					});
			});
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
		let list: EmailList = {
			verified: [],
			unverified: [],
			nonexistent: [],
		};
		let allUnverifiedUserEmails: string[] = org.unverifiedUsers.map(
			(value) => value.email
		);
		let allVerifiedUserEmails: string[] = org.users
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

	/**
	 * @param {number} length - Integer value of the length of the returned string
	 * @returns {string} Randomly generated string of numerical digits
	 * @description Will generate a string of random numerical digits from the charset variable.
	 * Length will be determined from the length parameter
	 */
	private generateCode(length: number): string {
		let charset = "0123456789";
		let result = "";
		for (let i = 0; i < length; i++)
			result += charset[Math.floor(Math.random() * charset.length)];
		return result;
	}
}
