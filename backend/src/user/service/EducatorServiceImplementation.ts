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

export class EducatorService {
    emailService: EmailService;

    constructor() {
        this.emailService = new MockEmailService();
    }

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

    private CategoriseEducatorsFromEmails(emails: string[], org: Organisation): EmailList {
        let list: EmailList = {
            verified: [],
            unverified: [],
            nonexistent: []
        }
        let allUnverifiedUserEmails: string[] = org.unverifiedUsers.map(value => value.email);
        let allVerifiedUserEmails: string[] = org.users.filter(value => value.educator).map(value => value.email);
        
        list.unverified = emails.filter(value => allUnverifiedUserEmails.includes(value))
        list.nonexistent = emails.filter(value => !list.unverified.includes(value)).filter(value => !allVerifiedUserEmails.includes(value));

        return list;
    }

    private generateCode(length: number): string {
		let charset = '0123456789';
		let result = '';
		for (let i = 0; i < length; i++) result += charset[Math.floor(Math.random() * charset.length)];
		return result;
	}
} 