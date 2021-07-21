import { User } from "../database/User";
import { getRepository } from "typeorm";
import { RevokeUserFromAdminRequest } from "../models/user/RevokeUserFromAdminRequest";
import { SetUserToAdminRequest } from "../models/user/SetUserToAdminRequet";

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
			if (user.educator.adminisAdmin) {
				user.isAdmin = false;
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
				// add user is not an admin expetion
				return false;
			}
		} else {
			// add user not found exception
			return false;
		}
	}

	public async revokeUserFromAdmin(request: RevokeUserFromAdminRequest) {
		if (request.username == null) {
			//TO DO EXCEPTION
			return false;
		}

		let userRepo = getRepository(User);
		let username = request.username;
		let user = await userRepo.findOne({ where: { username: username } });

		if (user) {
			if (user.isAdmin) {
				user.isAdmin = false;
				userRepo.save(user).then((saved) => {
					if (saved) {
						// user successfully revoked from admin
						return true;
					}
					// saving to data base error
					return false;
				});
			} else {
				// add user is not an admin expetion
				return false;
			}
		} else {
			// add user not found exception
			return false;
		}
	}
}
