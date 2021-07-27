import { getConnection, getRepository } from "typeorm";
import { User } from "../database/User";
import { genPassword, issueJWT, validPassword } from "../helper/auth/utils";
import { RegisterRequest } from "../models/auth/RegisterRequest";
import { LoginRequest } from "../models/auth/LoginRequest";
import { VerifyInvitationRequest } from "../models/auth/VerifyInvitationRequest";
import { UnverifiedUser } from "../database/UnverifiedUser";
import { Organisation } from "../database/Organisation";
import { Educator } from "../database/Educator";
import { DatabaseError } from "../errors/DatabaseError";
import { NonExistantItemError } from "../errors/NonExistantItemError";
import { InvalidParameterError } from "../errors/InvalidParametersError";
import { validateRegisterRequest } from "./validations/AuthValidate";

let statusRes: any = {
	message: "",
	type: "fail",
	token: undefined,
};

export class AuthService {
	public async register(request: RegisterRequest) {
		// Check if parameters are set
		try {
			validateRegisterRequest(request);
		} catch (error) {
			throw error;
		}

		if (request.userType == "OrganizationAdmin") {
			// registering the first admin for an organization
			return this.firstAdminRegistration(request);
		}

		// educator or student registration

		return this.userRegistration(request);
	}

	public async login(request: LoginRequest) {
		let UserRepo = getRepository(User);

		// Find user with given Username
		return UserRepo.findOne({ where: { username: request.username } })
			.then((user) => {
				if (!user) {
					throw new NonExistantItemError(
						`User with username ${request.username} not found`
					);
				}

				// validate password of user
				let isValid = validPassword(
					request.password,
					user.hash,
					user.salt
				);

				if (isValid) {
					// issue jwt token for the user
					statusRes.token = issueJWT(user).token;
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

	public async verifyInvitation(request: VerifyInvitationRequest) {
		// check if user is already registered

		let existingUser = await getRepository(User).findOne({
			where: { email: request.email },
		});

		if (existingUser) {
			statusRes.message = "Email used already registered";
			return statusRes;
		}

		// Check if email of user is in invitation list
		let invitationRepo = getRepository(UnverifiedUser);

		let user = await invitationRepo.findOne({
			where: { email: request.email },
		});

		if (user) {
			// the user has been invited by educator
			// now check if user verification code is valid

			if (user.verificationCode == request.verificationCode) {
				// set user as verified
				let verified: boolean = await this.setUserToverified(user.id);
				if (verified) {
					statusRes.message = "Invitiation code is valid";
					statusRes.type = "success";
				}

				return statusRes;
			} else {
				statusRes.message = "Invitation code is invalid";
				return statusRes;
			}
		} else {
			statusRes.message =
				"User has not been invited to sign up for EduGo";
			return statusRes;
		}
	}

	public async setUserToverified(user_id: number) {
		try {
			await getConnection()
				.createQueryBuilder()
				.update(UnverifiedUser)
				.set({ verified: true })
				.where("id = :id", { id: user_id })
				.execute();
		} catch (err) {
			throw new DatabaseError(
				`Unable to update unverified UserID ${user_id} to true`
			);
		}
		return true;
	}

	public async doesEmailExist(request: RegisterRequest) {
		let userRepo = getRepository(User);
		// check if username and password exist
		let emailExists = await userRepo.findOne({
			where: { email: request.user_email },
		});

		if (emailExists) return true;

		return false;
	}

	public async doesUsernameExist(request: RegisterRequest) {
		let userRepo = getRepository(User);
		// check if username and password exist
		let usernameExists = await userRepo.findOne({
			where: { username: request.username },
		});

		if (usernameExists) return true;

		return false;
	}

	public async userRegistration(request: RegisterRequest) {
		// if user name and password don't exist proceed

		let userRepo = getRepository(User);
		if (
			!(await this.doesEmailExist(request)) &&
			!(await this.doesUsernameExist(request))
		) {
			// check if user did verify their number
			let invitedUser = await getRepository(UnverifiedUser).findOne({
				where: { email: request.user_email },
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

				let org = invitedUser.organisation;

				let user = new User();
				user.email = request.user_email.toLowerCase();
				user.firstName = request.user_firstName;
				user.lastName = request.user_lastName;
				user.username = request.username.toLowerCase();
				const saltHAsh = genPassword(request.password);
				user.salt = saltHAsh.salt;
				user.hash = saltHAsh.hash;
				user.organisation = org;
				return userRepo
					.save(user)
					.then((result) => {
						// removing user from unverified list after they have registered successfully
						if (invitedUser)
							getRepository(UnverifiedUser).delete(invitedUser);

						statusRes.message = "User registered";
						statusRes.type = "success";

						return statusRes;
					})
					.catch((err) => {
						throw new DatabaseError(
							"User unable to be saved to DB"
						);
					});
			} else {
				statusRes.message =
					"Email address that was invited with doesn't match provided email address";

				statusRes.type = "fail";
				statusRes.token = undefined;
				console.log(statusRes);

				return statusRes;
			}
		}
	}

	public async emailExists(request: RegisterRequest) {
		let userRepo = getRepository(User);
		//Check if user exists with specified username and email address
		let emailExists = await userRepo.findOne({
			where: { email: request.user_email },
		});
		if (emailExists == undefined) return true;

		return false;
	}
	public async usernameExists(request: RegisterRequest) {
		let userRepo = getRepository(User);

		let usernameExists = await userRepo.findOne({
			where: { username: request.username },
		});
		console.log(usernameExists);
		if (usernameExists == undefined) return true;

		return false;
	}

	public async firstAdminRegistration(request: RegisterRequest) {
		let userRepo = getRepository(User);
		let organisation: Organisation;
		if (
			!(await this.doesEmailExist(request)) &&
			!(await this.doesUsernameExist(request))
		) {
			try {
				let org = await getRepository(Organisation).findOne(
					request.organisation_id
				);
				if (org) organisation = org;
				else {
					throw new NonExistantItemError("Organisation not found");
				}
			} catch (error) {
				throw error;
			}

			let user = new User();
			user.email = request.user_email.toLowerCase();
			user.firstName = request.user_firstName;
			user.lastName = request.user_lastName;
			user.username = request.username.toLowerCase();
			const saltHAsh = genPassword(request.password);
			user.salt = saltHAsh.salt;
			user.hash = saltHAsh.hash;

			user.educator = new Educator();
			user.educator.admin = true;
			user.organisation = organisation;
			return userRepo
				.save(user)
				.then((result) => {
					statusRes.message = "First admin User registered";
					statusRes.type = "success";
					return statusRes;
				})
				.catch((err) => {
					throw new DatabaseError("User unable to be saved to DB");
				});
		} else {
			return "username and email already exist";
		}
	}
}
