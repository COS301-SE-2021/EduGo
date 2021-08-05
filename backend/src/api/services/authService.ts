import { getConnection, getRepository } from "typeorm";
import { User } from "../database/User";
import { genPassword, issueJWT, validPassword } from "../helper/auth/utils";
import { RegisterRequest, userType } from "../models/auth/RegisterRequest";
import { LoginRequest } from "../models/auth/LoginRequest";
import { VerifyInvitationRequest } from "../models/auth/VerifyInvitationRequest";
import { UnverifiedUser } from "../database/UnverifiedUser";
import { Organisation } from "../database/Organisation";
import { Educator } from "../database/Educator";
import { DatabaseError } from "../errors/DatabaseError";
import { NonExistantItemError } from "../errors/NonExistantItemError";
import { InvalidParameterError } from "../errors/InvalidParametersError";
import { validateRegisterRequest } from "./validations/AuthValidate";
import { Student } from "../database/Student";
import { Error400 } from "../errors/Error";

export class AuthService {
	public async register(request: RegisterRequest) {
		// Check if parameters are set
		try {
			validateRegisterRequest(request);
		} catch (error) {
			throw error;
		}

		if (request.userType == userType.firstAdmin) {
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

					return { token: issueJWT(user).token };
				} else {
					throw new Error400("Incorrect Password");
				}
			})
			.catch((err) => {
				throw err;
			});
	}

	// User invitation code before registering

	/**
	 * @description this function is used to verify the invitation code that was sent to user
	 * 1. check if user is already registered
	 * 2. Check if email of user is in invitation list
	 * 3. Check if user verification code is valid
	 * 4. Set user as verified
	 * @param {VerifyInvitationRequest} request
	 * @returns {*}
	 * @memberof AuthService
	 */
	public async verifyInvitation(request: VerifyInvitationRequest) {
		let existingUser = await getRepository(User).findOne({
			where: { email: request.email },
		});

		if (existingUser) {
			throw new NonExistantItemError("User is already registered");
		}

		let invitationRepo = getRepository(UnverifiedUser);

		let user = await invitationRepo.findOne({
			where: { email: request.email },
		});

		if (user) {
			if (user.verificationCode == request.verificationCode) {
				try {
					let verified: boolean = await this.setUserToverified(
						user.id
					);
					if (verified) {
						return;
					} else {
						throw new NonExistantItemError(
							"User not found in unverified list"
						);
					}
				} catch (err) {
					throw err;
				}
			} else {
				throw new Error400("Invitation code is invalid");
			}
		} else {
			throw new Error400(
				"User has not been invited to sign up for EduGo"
			);
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
			throw err;
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

	public async userRegistration(request: RegisterRequest): Promise<void> {
		// if user name and password don't exist proceed
		let unverifiedUserRepo = getRepository(UnverifiedUser);
		let userRepo = getRepository(User);

		let unverifiedUserRepo = getRepository(UnverifiedUser);
		if (!(await this.doesEmailExist(request))) {
			if (!(await this.doesUsernameExist(request))) {
				// check if user did verify their number
				let invitedUser = await unverifiedUserRepo.findOne({
					where: { email: request.user_email },
					relations: ['subjects', 'organisation']
				});
				// Only invited users can register
				if (invitedUser) {
					if (!invitedUser.verified) {
						throw new NonExistantItemError("User has not been Invited");
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

					//TODO Test if this works
					// add subjects that user was invited to their relation
					if (request.userType == userType.student) {
						user.student = new Student();

						for (let index of invitedUser.subjects) {
							user.student.subjects.push(index);
						}
					} else {
						user.educator = new Educator();
						for (let index of invitedUser.subjects) {
							user.educator.subjects.push(index);
						}
					}

					try {
						await userRepo.save(user)
					}
					catch (err) {
						throw new DatabaseError(
							"User unable to be saved to DB"
						);
					}
					// removing user from unverified list after they have registered successfully
					//TODO figure out what is wrong with the delete function for unverified user
					//await unverifiedUserRepo.delete(invitedUser);
					return;
				} else {
					throw new NonExistantItemError(
						"Email address that was invited with doesn't match provided email address"
					);
				}
			}
			else throw new Error400("Username already exists");
		}
		else throw new Error400("Email already exists");
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
					return;
				})
				.catch((err) => {
					throw new DatabaseError("User unable to be saved to DB");
				});
		} else {
			return new Error400("username and email already exist");
		}
	}
}
