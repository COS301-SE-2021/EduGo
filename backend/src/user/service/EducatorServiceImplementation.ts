import { MockEmailService } from "../../email/MockEmailService";
import { EmailService } from "../../email/EmailService";
import { AddEducatorsRequest } from "../models/AddEducatorsRequest";
import { validateEmails } from "../validate";
import { getRepository, In } from "typeorm";
import { Organisation } from "../../database/entity/Organisation";
import { DatabaseError } from "../../exceptions/DatabaseError";
import { UnverifiedUser } from "../../database/entity/UnverifiedUser";
import { User } from "../../database/entity/User";
import { EmailList } from "../models/SerivceModels";
import { VerificationEmail } from "../../email/models/VerificationEmail";
import { EmailError } from "../../exceptions/EmailError";

/**
 * A class consisting of the functions that make up the educator service
 * @class EducatorService
 */
export class EducatorService {
    emailService: EmailService;

    /**
     * Create an educator service
     */
    constructor() {
        this.emailService = new MockEmailService();
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
    public async AddEducators(request: AddEducatorsRequest): Promise<void> {
        let emails: string[] = request.educators;
        let organisationRepository = getRepository(Organisation);

        if (validateEmails(emails)) {
            organisationRepository.findOne(request.organisation_id, {relations: ["users", "unverifiedUsers"]}).then(org => {
                if (!org)
                    throw new DatabaseError('Could not find organisation')

                let list = this.CategoriseEducatorsFromEmails(emails, org);
                this.HandleNonExistentEducators(list.nonexistent, org);
                this.HandleUnverifiedEducators(list.unverified);
            })
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
        getRepository(UnverifiedUser).find({where: {email: In(emails)}}).then(users => {
            let reminderEmails: VerificationEmail[] = users.filter(value => value).map(value => {
                return {email: value.email, code: value.verificationCode}
            })

            this.emailService.SendBulkVerificationReminderEmails(reminderEmails).then(result => {
                if (!result)
                    throw new EmailError('Could not send all emails')
            })
        })
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
    private async HandleNonExistentEducators(emails: string[], org: Organisation) {
        let users: UnverifiedUser[] = emails.map(value => {
            let user: UnverifiedUser = new UnverifiedUser();
            user.email = value;
            user.type = 'educator';
            user.subjects = [];
            user.verificationCode = this.generateCode(5);
            user.organisation = org
            return user;
        })

        let unverifiedEmails: VerificationEmail[] = users.map(value => {
            return {code: value.verificationCode, email: value.email}
        })
        getRepository(UnverifiedUser).save(users).then(() => {
            this.emailService.SendBulkVerificationEmails(unverifiedEmails).then(result => {
                if (!result)
                    throw new EmailError('Could not send all emails')
            })
        })
    }

    /**
     * @param {string[]} emails - An unsorted/uncategorised/unvalidated/unverified array of email addresses of educators
     * @param {Organisation} org - An object detailing the current organisation, includes the unverifiedUsers relation
     * @returns {EmailList} - An object containing 3 string arrays
     * @description 
     */
    private CategoriseEducatorsFromEmails(emails: string[], org: Organisation): EmailList {
        let list: EmailList = {
            verified: [],
            unverified: [],
            nonexistent: []
        }
        let allUnverifiedUserEmails: string[] = org.unverifiedUsers.map(value => value.email);
        let allVerifiedUserEmails: string[] = org.users.filter(value => value.educator).map(value => value.email);
        
        list.unverified = emails.filter(value => allUnverifiedUserEmails.includes(value))
        list.nonexistent = emails
            .filter(value => !list.unverified.includes(value))
            .filter(value => !allVerifiedUserEmails.includes(value));

        return list;
    }

    /**
     * @param {number} length - Integer value of the length of the returned string
     * @returns {string} Randomly generated string of numerical digits
     * @description Will generate a string of random numerical digits from the charset variable.
     * Length will be determined from the length parameter
     */
    private generateCode(length: number): string {
		let charset = '0123456789';
		let result = '';
		for (let i = 0; i < length; i++) result += charset[Math.floor(Math.random() * charset.length)];
		return result;
	}
} 