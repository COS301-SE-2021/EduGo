import { User } from "../database/User";
import {  Repository } from "typeorm";
import { RevokeUserFromAdminRequest } from "../models/user/RevokeUserFromAdminRequest";
import { SetUserToAdminRequest } from "../models/user/SetUserToAdminRequet";
import { DatabaseError } from "../errors/DatabaseError";
import { handleSavetoDBErrors } from "../helper/ErrorCatch";
import { NonExistantItemError } from "../errors/NonExistantItemError";
import { InvalidParameterError } from "../errors/InvalidParametersError";
import { Service } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import { getUserDetails } from "../helper/auth/Userhelper";
import { GetUserDetailsResponse } from "../models/user/GetUserDetailsResponse";
import { userType } from "../models/auth/RegisterRequest";

@Service()
export class UserService {
	@InjectRepository(User) private userRepository: Repository<User>;

	public async setUserToAdmin(request: SetUserToAdminRequest) {
		if (request.username == null) {
			throw new InvalidParameterError("Username not provided");
		}
		// TODO change this to cater for Educators not user
		let username = request.username;
		let user = await this.userRepository.findOne({
			where: { username: username },
			relations: ["educator"],
		});

		if (user) {
			if (user.educator) {
				if (!user.educator.admin) {
					user.educator.admin = true;
					this.userRepository
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

	public async getUserDetails(user_id: number) {
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

	public async revokeUserFromAdmin(request: RevokeUserFromAdminRequest) {
		if (request.username == null) {
			throw new InvalidParameterError("Username not provided");
		}

		let username = request.username;
		let user = await this.userRepository.findOne({
			where: { username: username },
			relations: ["educator"],
		});

		if (user) {
			if (user.educator) {
				if (user.educator.admin) {
					user.educator.admin = false;
					this.userRepository
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
