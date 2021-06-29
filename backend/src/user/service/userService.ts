import { ApiResponse } from "../../models/apiResponse";
import { getRepository, In } from "typeorm";
import { Educator } from "../../database/entity/Educator";
import { Student } from "../../database/entity/Student";
import { RegisterRequest } from "../models/registerRequest";
import utils from "../lib/utils";
import { AddUsersToSubjectRequest } from "../models/AddUsersToSubjectRequest";
import { validateEmail } from "../validate";
import { User } from "../../database/entity/User";
import { UnverifiedUser } from "../../database/entity/UnverifiedUser";
import { EmailError } from "../../exceptions/EmailError";
let statusRes: ApiResponse = {
	message: "",
	type: "fail",
};

// To Do
export async function makeUserAdmin(request: RegisterRequest) {}

export class UserService {
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
					let newEmails: string[] = emails.filter(value => !existingEmails.includes(value))

					let unverifiedUsers: UnverifiedUser[] = newEmails.map(value => {
						let user: UnverifiedUser = new UnverifiedUser()
						user.email = value;
						user.verificationCode = this.generateCode(5);
						return user;
					})

					if (existingEmails.length + unverifiedUsers.length === emails.length) {
						this.sendVerificationEmails(unverifiedUsers).then(count => {
							if (count !== unverifiedUsers.length)
								throw new EmailError('Not all the emails were sent')
							let unverifiedUserRepo = getRepository(UnverifiedUser);
							unverifiedUserRepo.save(unverifiedUsers).then(savedUsers => {
								
							})
						})
						.catch(err => {

						})
					}
				})
		}
	}

	private async sendVerificationEmails(users: UnverifiedUser[]): Promise<number> {

	}

	private generateCode(length: number): string {
		let charset = '0123456789';
		let result = '';
		for (let i = 0; i < length; i++) result += charset[Math.floor(Math.random() * charset.length)];
		return result;
	}
}
