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
	token: undefined,
};

export async function register(request: RegisterRequest) {
	// Check if parameters are set
	if (
		request.email == null ||
		request.firstName == null ||
		request.lastName == null ||
		request.username == null ||
		request.organizationId == null ||
		request.userType == null
	) {
		statusRes.message = "Missing Parameters";
		statusRes.type = "success";
		return statusRes;
	}

	let userRepo = getRepository(User);
	//Check if user exists with specified username and email address
	let emailExists = await userRepo.findOne({
		where: { email: request.email },
	});
	let usernameExists = await userRepo.findOne({
		where: { username: request.username },
	});

	// username and password don't exist and contiue to registering user
	if (!emailExists && !usernameExists) {
		let user = new User();
		user.email = request.email.toLowerCase();
		user.firstName = request.firstName;
		user.lastName = request.lastName;
		user.username = request.username.toLowerCase();
		//TODO: Get the current organisation and set that
		//user.organizationId = request.organizationId;
		const saltHAsh = utils.genPassword(request.password);
		user.salt = saltHAsh.salt;
		user.hash = saltHAsh.hash;
		//TODO: Determine whether the user is a student or educator and react accordingly
		if (request.userType === 'student') {
			let student: Student = new Student();
			user.student = student;
		}
		else if (request.userType === 'educator') {
			let educator: Educator = new Educator();
			user.educator = educator;
		}

		return userRepo
			.save(user)
			.then((result) => {
				statusRes.message = "User registered";
				statusRes.type = "fail";
				return statusRes;
			})
			.catch((err) => {
				console.log(err);
			});
	} else {
		emailExists
			? (statusRes.message = "Email provided already exists")
			: (statusRes.message = "Username Provided already exists");
		statusRes.type = "fail";
		return statusRes;
	}
	// registration for a student
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

				statusRes.token = utils.issueJWT(user.id).token;
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
