import { User } from "../database/User";
import { Repository } from "typeorm";
import { RevokeUserFromAdminRequest } from "../models/user/RevokeUserFromAdminRequest";
import { SetUserToAdminRequest } from "../models/user/SetUserToAdminRequet";
import { Service } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import { getUserDetails } from "../helper/auth/Userhelper";
import { GetUserDetailsResponse } from "../models/user/GetUserDetailsResponse";
import { userType } from "../models/auth/RegisterRequest";
import {
	BadRequestError,
	ForbiddenError,
	NotFoundError,
} from "routing-controllers";
import { handleSavetoDBErrors } from "../helper/ErrorCatch";

@Service()
export class UserService {
	@InjectRepository(User) private userRepository: Repository<User>;

	public async SetUserToAdmin(
		request: SetUserToAdminRequest
	): Promise<string> {
		if (request.username == null) {
			throw new BadRequestError("Username not provided");
		}
		// TODO change this to cater for Educators not user
		const username = request.username;
		const user = await this.userRepository.findOne({
			where: { username: username },
			relations: ["educator"],
		});

		if (user) {
			if (user.educator) {
				if (!user.educator.admin) {
					user.educator.admin = true;
					try {
						await this.userRepository.save(user);
					} catch (err) {
						handleSavetoDBErrors(err);
					}
					return "ok";
				} else {
					throw new BadRequestError("User is already admin");
				}
			} else {
				throw new ForbiddenError("User is not an educator");
			}
		} else {
			throw new NotFoundError("user not found");
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
			const response: GetUserDetailsResponse = {
				email: user.email,
				firstName: user.firstName,
				lastName: user.lastName,
				username: user.username,
				organisation_id: user.organisation.id,
				userType: user.educator ? userType.educator : userType.student,
			};
			return response;
		}
	}

	public async RevokeUserFromAdmin(
		request: RevokeUserFromAdminRequest
	): Promise<string> {
		if (request.username == undefined) {
			throw new BadRequestError("Username not provided");
		}

		const username = request.username;
		const user = await this.userRepository.findOne({
			where: { username: username },
			relations: ["educator"],
		});

		if (user) {
			if (user.educator) {
				if (user.educator.admin) {
					user.educator.admin = false;
					try {
						await this.userRepository.save(user);
					} catch (err) {
						handleSavetoDBErrors(err);
					}
					return "ok";
				} else {
					throw new BadRequestError("User is already not an admin");
				}
			} else {
				throw new ForbiddenError("User is not an educator");
			}
		} else {
			throw new NotFoundError("user not found");
		}
	}
}
