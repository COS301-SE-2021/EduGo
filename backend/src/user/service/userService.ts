import { ApiResponse } from "../../models/apiResponse";
import { getRepository, In } from "typeorm";
import { Educator } from "../../database/entity/Educator";
import { Student } from "../../database/entity/Student";
//import { RegisterRequest } from "../models/registerRequest";
import utils from "../lib/utils";
import { AddUsersToSubjectRequest } from "../models/AddUsersToSubjectRequest";
import { validateEmail } from "../validate";
import { User } from "../../database/entity/User";
import { UnverifiedUser } from "../../database/entity/UnverifiedUser";
import { EmailError } from "../../exceptions/EmailError";
import { EmailService } from "../../email/EmailService";
import { MailgunEmailService } from "../../email/MailgunEmailService";
import { VerificationEmail } from "../../email/models/VerificationEmail";
let statusRes: ApiResponse = {
	message: "",
	type: "fail",
};

// To Do
//export async function makeUserAdmin(request: RegisterRequest) {}

type EmailStatus = 'existing' | 'unverified' | 'new';

export class UserService {
	emailService: EmailService;

	constructor() {
		this.emailService = new MailgunEmailService();
	}

	async AddUsersToSubject(request: AddUsersToSubjectRequest): Promise<void> {
		let emails: string[] = request.users;
		let valid = emails.every((value) => {
			return validateEmail(value);
		});

		if (valid) {
			let userRepo = getRepository(User);
			userRepo
				.find({
					email: In(emails)
				})
				.then(result => {
					let existingEmails: string[] = result.map(value => value.email)
					console.log('Existing');
					console.log(existingEmails);
					let newEmails: string[] = emails.filter(value => !existingEmails.includes(value))

					console.log('New');
					console.log(newEmails);

					let unverifiedUsers: UnverifiedUser[] = newEmails.map(value => {
						let user: UnverifiedUser = new UnverifiedUser()
						user.email = value;
						user.verificationCode = this.generateCode(5);
						return user;
					})
					console.log('Unverified');
					console.log(unverifiedUsers);

					if (existingEmails.length + unverifiedUsers.length === emails.length) {
						console.log('About to send emails');
						this.sendVerificationEmails(unverifiedUsers).then(emailsSent => {
							console.log(`Emails sent: ${emailsSent}`);
							if (!emailsSent)
								throw new EmailError('Not all the emails were sent')
							let unverifiedUserRepo = getRepository(UnverifiedUser);
							unverifiedUserRepo.save(unverifiedUsers).then(savedUsers => {
								this.sendVerificationEmails(unverifiedUsers).then(res => {
									console.log(res);
								})
							})
						})
						.catch(err => {

						})
					}
				})
		}
	}

	private async sendVerificationEmails(users: UnverifiedUser[]): Promise<boolean> {
		let emails: VerificationEmail[] = users.map(value => {return {code: value.verificationCode, email: value.email}})
		return this.emailService.SendBulkVerificationEmails(emails);
	}

	private generateCode(length: number): string {
		let charset = '0123456789';
		let result = '';
		for (let i = 0; i < length; i++) result += charset[Math.floor(Math.random() * charset.length)];
		return result;
	}
}
