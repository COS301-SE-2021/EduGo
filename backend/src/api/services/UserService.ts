import { User } from "../database/User";
import { getRepository } from "typeorm";
import { RevokeUserFromAdminRequest } from "../models/user/RevokeUserFromAdminRequest";
import { SetUserToAdminRequest } from "../models/user/SetUserToAdminRequet";
import { DatabaseError } from "../errors/DatabaseError";

export class UserService {
	public async setUserToAdmin(request: SetUserToAdminRequest) {
		if (request.username == null) {
			//TO DO EXCEPTION
			return null;
		}
		// TO DO change this to cater for Educators not user
		let userRepo = getRepository(User);
		let username = request.username;
		let user = await userRepo.findOne({ where: { username: username } });

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
							throw DatabaseError
							return false;
						});
				} else {
					// user is already admin
				}
			} else {
				// add user is not an educator
				return false;
			}
		} else {
			// add user not found exception
			return false;
		}
	}

	public async revokeUserFromAdmin(request: RevokeUserFromAdminRequest) {
		if (request.username == null) {
			//TODO EXCEPTION
			return false;
		}
		
		let userRepo = getRepository(User);
		let username = request.username;
		let user = await userRepo.findOne({ where: { username: username } });

		if (user) {
			if (user.educator) {
				if (!user.educator.admin) {
					user.educator.admin = false;
					userRepo
						.save(user)
						.then((saved) => {
							return true;
						})
						.catch((err) => {
							// exception for database unable to save
							console.log(err.message);
							return false;
						});
				} else {
					// user is already admin
				}
			} else {
				// add user is not an educator
				return false;
			}
		} else {
			// add user not found exception
			return false;
		}
	}
}
