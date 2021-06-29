import { ApiResponse } from "../../models/apiResponse";
import { Lesson } from "../../database/entity/Lesson";
import { Any, createConnection, getConnection, getRepository } from "typeorm";
import { Subject } from "../../database/entity/Subject";
import { Educator } from "../../database/entity/Educator";
import { Student } from "../../database/entity/Student";
import { User } from "../../database/entity/User";
import utils from "../lib/utils";
import { RegisterRequest } from "../models/RegisterRequest";
import { LoginRequest } from "../models/LoginRequest";

let statusRes: any = {
	message: "",
	type: "fail",
	token: null,
};

export async function register(request: RegisterRequest) {
	let conn = getConnection();
	// registration for a student
	let user = new User();
	user.email = request.email;
	user.firstName = request.firstName;
	user.lastName = request.lastName;
	user.username = request.username;
	user.organizationId = request.organizationId;
	user.verified = false;
	const saltHAsh = utils.genPassword(request.password);
	user.salt = saltHAsh.salt;
	user.hash = saltHAsh.hash;
	user.isAdmin = false;
	user.type = request.userType;
	//user.admin = false;
	let userRepo = conn.getRepository(User);

	return userRepo
		.save(user)
		.then((result) => {
			statusRes.message = "Educator registered";
			statusRes.type = "success";
			return statusRes;
		})
		.catch((err) => {
			console.log(err);
		});
}

export async function login(request: LoginRequest) {
	let UserRepo = getRepository(User);

	// Find user with given Username
	return UserRepo.findOne({ where: { username: request.username } })
		.then((user) => {
			if (!user) {
				statusRes.message = "User doesn't exist";
				return statusRes;
			}

			// validate password of user
			let isvalid = utils.validPassword(
				request.password,
				user.hash,
				user.salt
			);

			if (isvalid) {
				// issue jwt token for the user

				statusRes.token = utils.issueJWT(user.id);
				statusRes.message = "User Logged in";
				statusRes.type = "success";
				return statusRes;
			} else {
				statusRes.message = "Password is invalid";
				return statusRes;
			}
		})
		.catch((err) => {
			console.log(err);
		});
}
