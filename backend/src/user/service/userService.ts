import { ApiResponse } from "../../models/apiResponse";
import { getRepository, In } from "typeorm";
import { Educator } from "../../database/entity/Educator";
import { Student } from "../../database/entity/Student";
//import { RegisterRequest } from "../models/registerRequest";
import utils from "../lib/utils";
import { AddUsersToSubjectRequest } from "../models/AddUsersToSubjectRequest";
import { validateEmail, validateEmails } from "../validate";
import { User } from "../../database/entity/User";
import { UnverifiedUser } from "../../database/entity/UnverifiedUser";
import { EmailError } from "../../exceptions/EmailError";
import { EmailService } from "../../email/EmailService";
import { MailgunEmailService } from "../../email/MailgunEmailService";
import { VerificationEmail } from "../../email/models/VerificationEmail";
import { EmailList } from '../models/SerivceModels';
import { AddedToSubjectEmail } from "../../email/models/AddedToSubjectEmail";
import { Subject } from "../../database/entity/Subject";
import { DatabaseError } from "../../exceptions/DatabaseError";

// To Do
//export async function makeUserAdmin(request: RegisterRequest) {}



export class UserService {
	emailService: EmailService;

	constructor() {
		this.emailService = new MailgunEmailService();
	}

	async AddUsersToSubject(request: AddUsersToSubjectRequest): Promise<void> {
		let emails: string[] = request.users;

		if (validateEmails(emails)) {
			this.GetUsersAndUnverifiedUsersFromEmails(emails).then(emailList => {
				console.log('Email List')
				console.log(emailList);

				let nonExistingUsers: UnverifiedUser[] = emailList.nonexistent.map(value => {
					let user: UnverifiedUser = new UnverifiedUser();
					user.email = value;
					user.verificationCode = this.generateCode(5);
					return user;
				})

				this.sendVerificationEmails(nonExistingUsers).then(emailsSent => {
					if (!emailsSent)
						throw new EmailError('Not all the emails were sent');

					getRepository(UnverifiedUser).save(nonExistingUsers).then(savedUsers => {
						console.log(`${savedUsers.length} users saved`);
					})
				})

				this.GetUnverifiedUsersWithVerificationCodes(emailList.unverified).then(users => {
					this.SendReminderEmails(users).then(emailsSent => {
						if (!emailsSent)
							throw new EmailError('Not all the emails were sent');
					})
				})

				this.GetUsersFromEmails(emailList.verified).then(users => {
					getRepository(Subject).findOne(request.subject_id).then(subject => {
						if (subject) {
							subject.students.push(...users);

							//TODO: Review this
							getRepository(Subject).save(subject)
							.catch(err => {
								throw new DatabaseError('Users could not be added to database')
							})

							let verifiedUsers: AddedToSubjectEmail[] = users.map(value => {
								let email: AddedToSubjectEmail = {
									email: value.email,
									name: value.firstName,
									subject: subject.title
								}
								return email;
							});
							this.SendAddedToSubjectEmails(verifiedUsers).then(emailsSent => {
								if (!emailsSent)
									throw new EmailError('Not all the emails were sent');
							})
						}
						else throw new Error('Subject could not be found')
					})
				})
			});
		}
	}

	private async sendVerificationEmails(users: UnverifiedUser[]): Promise<boolean> {
		let emails: VerificationEmail[] = users.map(value => {return {code: value.verificationCode, email: value.email}})
		return this.emailService.SendBulkVerificationEmails(emails);
	}

	private async SendReminderEmails(users: UnverifiedUser[]): Promise<boolean> {
		let emails: VerificationEmail[] = users.map(value => {return {code: value.verificationCode, email: value.email}})
		return this.emailService.SendBulkVerificationReminderEmails(emails);
	}

	private async SendAddedToSubjectEmails(users: AddedToSubjectEmail[]): Promise<boolean> {
		throw new Error('')
	}

	private generateCode(length: number): string {
		let charset = '0123456789';
		let result = '';
		for (let i = 0; i < length; i++) result += charset[Math.floor(Math.random() * charset.length)];
		return result;
	}

	private async GetUsersAndUnverifiedUsersFromEmails(emails: string[]): Promise<EmailList> {
		let userRepo = getRepository(User);
		let unverifiedUserRepo = getRepository(UnverifiedUser);

		//Find verified users from FULL list of emails
		return this.GetUsersFromEmails(emails).then(userResult => {
			//Get list of existing verified user emails
			let existingVerifiedUserEmails: string[] = userResult.map(value => value.email);

			//Get remaining emails (possibly unverified or nonexistent)
			let remainingEmails: string[] = emails.filter(value => !existingVerifiedUserEmails.includes(value));

			//Find the unverified users from the remaining email list
			return unverifiedUserRepo.find({email: In(remainingEmails)}).then(unverifiedUserResult => {
				//Get the emails of all the unverified users
				let existingUnverifiedUserEmails: string[] = unverifiedUserResult.map(value => value.email);

				let nonExistingUsers: string[] = remainingEmails.filter(value => !existingUnverifiedUserEmails.includes(value))
				return {
					verified: existingVerifiedUserEmails,
					unverified: existingUnverifiedUserEmails,
					nonexistent: nonExistingUsers
				}
			})
		})
	}

	private async GetUnverifiedUsersWithVerificationCodes(emails: string[]): Promise<UnverifiedUser[]> {
		return getRepository(UnverifiedUser).find({email: In(emails)}).then(users => users);
	}

	private async GetUsersFromEmails(emails: string[]): Promise<User[]> {
		return getRepository(User).find({email: In(emails)}).then(users => users);
	}

}
