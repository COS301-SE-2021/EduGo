import { User } from "../database/User";
import { getRepository } from "typeorm";
import { RevokeUserFromAdminRequest } from "../models/user/RevokeUserFromAdminRequest";
import { SetUserToAdminRequest } from "../models/user/SetUserToAdminRequet";
import { DatabaseError } from "../errors/DatabaseError";
import { handleSavetoDBErrors } from "../helper/ErrorCatch";
import { NonExistantItemError } from "../errors/NonExistantItemError";
import { InvalidParameterError } from "../errors/InvalidParametersError";
import { getUserDetails } from "../helper/auth/Userhelper";
import { GetUserDetailsResponse } from "../models/user/GetUserDetailsResponse";
import { userType } from "../models/auth/RegisterRequest";

export class UserService {
	async getUserDetails(user_id: number) {
		let user: User;
		try {
			user = await getUserDetails(user_id);
		} catch (error) {
			throw error;
		}

		if (user) {
			let response: GetUserDetailsResponse = {
				email: user.email,
				firstName: user.email,
				lastName: user.lastName,
				username: user.username,
				organisation_id: user.organisation.id,
				userType: user.educator ? userType.educator : userType.student,
			};
			return response;
		}
	}
	public async setUserToAdmin(request: SetUserToAdminRequest) {
		if (request.username == null) {
			throw new InvalidParameterError("Username not provided");
		}
		// TO DO change this to cater for Educators not user
		let userRepo = getRepository(User);
		let username = request.username;
		let user = await userRepo.findOne({
			where: { username: username },
			relations: ["educator"],
		});

		if (user) {
			if (user.educator) {
				if (!user.educator.admin) {
					user.educator.admin = true;
					userRepo
						.save(user)
						.then((saved) => {
							return true;
						})
						.catch((err) => {
							handleSavetoDBErrors(err);
						});
				} else {
					throw new DatabaseError("User is already admin");
				}
			} else {
				throw new NonExistantItemError("User is not an educator");
			}
		} else {
			throw new NonExistantItemError("user not found");
		}
	}

	public async revokeUserFromAdmin(request: RevokeUserFromAdminRequest) {
		if (request.username == null) {
			throw new InvalidParameterError("Username not provided");
		}

		let userRepo = getRepository(User);
		let username = request.username;
		let user = await userRepo.findOne({
			where: { username: username },
			relations: ["educator"],
		});

		if (user) {
			if (user.educator) {
				if (user.educator.admin) {
					user.educator.admin = false;
					userRepo
						.save(user)
						.then((saved) => {
							return true;
						})
						.catch((err) => {
							handleSavetoDBErrors(err);
						});
				} else {
					throw new DatabaseError("User is already not an admin");
				}
			} else {
				throw new NonExistantItemError("User is not an educator");
			}
		} else {
			throw new NonExistantItemError("user not found");
		}
	}
}
