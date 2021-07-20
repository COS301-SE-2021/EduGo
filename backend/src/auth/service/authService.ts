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
import { VerifyInvitationRequest } from "../models/VerifyInvitationRequest";
import { UnverifiedUser } from "../../database/entity/UnverifiedUser";

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
		request.userType == null
	) {
		statusRes.message = "Missing Parameters";
		statusRes.type = "success";
		return statusRes;
	}

	if (request.userType == "OrganizationAdmin") {
		// registering the first admin for an organization
		return firstAdminRegistration(request);
	}

	// educator or student registration
	return userRegistration(request);
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

				statusRes.token = utils.issueJWT(user).token;
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

// User invitation code before registering

export async function verifyInvitation(request: VerifyInvitationRequest) {
	// check if user is already registered

	let existingUser = await getRepository(User).findOne({
		where: { email: request.email },
	});

	if (existingUser) {
		statusRes.message = "Email used already registered";
		return statusRes;
	}

	// Check if email of user is in invitation list
	let inviatationRepo = getRepository(UnverifiedUser);

	let user = await inviatationRepo.findOne({
		where: { email: request.email },
	});

	if (user) {
		// the user has been invited by educator
		// now check if user verification code is valid

		if (user.verificationCode == request.verificationCode) {
			// set user as verified
			let verified: boolean = <boolean>(
				(<unknown>setUserToverified(user.id))
			);
			if (verified) {
				statusRes.message = "Invitiation code is valid";
				statusRes.type = "success";
			} else {
				statusRes.message = "User unable to be verified";
				return statusRes;
			}

			return statusRes;
		} else {
			statusRes.message = "Invitation code is invalid";
			return statusRes;
		}
	} else {
		statusRes.message = "User has not been invited to sign up for EduGo";
		return statusRes;
	}
}

async function setUserToverified(user_id: number) {
	try {
		await getConnection()
			.createQueryBuilder()
			.update(UnverifiedUser)
			.set({ verified: true })
			.where("id = :id", { id: user_id })
			.execute();
	} catch (err) {
		console.log(err);
		return false;
	}
	return true;
}

async function userRegistration(request: RegisterRequest) {
	// check if user has entered invitation code
	let verifiedUser = await getRepository(UnverifiedUser).findOne({
		where: { email: request.email, verified: true },
	});

	if (!verifiedUser) {
		// TODO user not verified exception
		//
	}
	let userRepo = getRepository(User);
	// username and email don't exist and contiue to registering user
	if (!emailExists(request) && !usernameExists(request)) {
		let invitedUser = await getRepository(UnverifiedUser).findOne({
			where: { email: request.email },
		});
		// Only invited users can register
		if (invitedUser) {
			if (!invitedUser.verified) {
				statusRes.message =
					"User has not verified account using invitation code";
				statusRes.type = "fail";
				statusRes.token = undefined;
				return statusRes;
			}

			let user = new User();
			user.email = request.email.toLowerCase();
			user.firstName = request.firstName;
			user.lastName = request.lastName;
			user.username = request.username.toLowerCase();
			const saltHAsh = utils.genPassword(request.password);
			user.salt = saltHAsh.salt;
			user.hash = saltHAsh.hash;

			return userRepo
				.save(user)
				.then((result) => {
					// removing user from unverified list after they have registerd successfully
					if (invitedUser)
						getRepository(UnverifiedUser).delete(invitedUser);

					statusRes.message = "User registered";
					statusRes.type = "success";
					return statusRes;
				})
				.catch((err) => {
					console.log(err);
				});
		} else {
			statusRes.message =
				"Email address that was invited with doesn't match provided email address";

			statusRes.type = "fail";
			statusRes.token = undefined;
			return statusRes;
		}
	}
}

async function emailExists(request: RegisterRequest) {
	let userRepo = getRepository(User);
	//Check if user exists with specified username and email address
	let emailExists = await userRepo.findOne({
		where: { email: request.email },
	});
	// TODO add exceptions
}

async function usernameExists(request: RegisterRequest) {
	let userRepo = getRepository(User);

	let usernameExists = await userRepo.findOne({
		where: { username: request.username },
	});
	// TODO add exceptions
}

async function firstAdminRegistration(request: RegisterRequest) {
	if (!emailExists(request) && !usernameExists(request)) {
		let user = new User();
		user.email = request.email.toLowerCase();
		user.firstName = request.firstName;
		user.lastName = request.lastName;
		user.username = request.username.toLowerCase();
		const saltHAsh = utils.genPassword(request.password);
		user.salt = saltHAsh.salt;
		user.hash = saltHAsh.hash;
		let userRepo = getRepository(User);

		return userRepo
			.save(user)
			.then((result) => {
				statusRes.message = " First admin User registered";
				statusRes.type = "success";
				return statusRes;
			})
			.catch((err) => {
				console.log(err);
				// TODO database save error
			});
	}
}
