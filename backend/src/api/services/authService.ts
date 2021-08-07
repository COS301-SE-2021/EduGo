import { Repository } from "typeorm";
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
import { validateRegisterRequest } from "./validations/AuthValidate";
import { Student } from "../database/Student";
import { Error400 } from "../errors/Error";
import { Service } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import { LoginResponse } from "../models/auth/LoginResponse";

@Service()
export class AuthService {
	@InjectRepository(User) private userRepository: Repository<User>;
	@InjectRepository(UnverifiedUser)
	private unverifiedUserRepository: Repository<UnverifiedUser>;
	@InjectRepository(Organisation)
	private organisationRepository: Repository<Organisation>;
	/**
	 * @description This function allows for a user to register onto the platform
	 * 1. If User Type is the first admin for an organisation firstAdminRegistration will be used 
	 * 2. If the user type is a student or an educator then userRegistration will be used 
	 * @param {RegisterRequest} request
	 * @returns {*}
	 * @memberof AuthService
	 */
	public async register(request: RegisterRequest) {
		if (request.userType == userType.firstAdmin) {
			// registering the first admin for an organization
			return this.firstAdminRegistration(request);
		}

		// educator or student registration

		return this.userRegistration(request);
	}

/**
 * @description This endpoint allows for login in and returns a the JWT token 
 * 1. Check if user with given username exists 
 * 2. Validate the password entered 
 * 3. Issue the JWT Token 
 * @param {LoginRequest} request
 * @returns {Promise<LoginResponse>}
 * @memberof AuthService
 */
public async login(request: LoginRequest) :Promise<LoginResponse>{
		return this.userRepository
			.findOne({ where: { username: request.username } })
			.then((user) => {
				if (!user) {
					throw new NonExistantItemError(
						`User with username ${request.username} not found`
					);
				}

				let isValid = validPassword(
					request.password,
					user.hash,
					user.salt
				);

				if (isValid) {

					 let response:LoginResponse ={ token: issueJWT(user).token };
					return response
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
	 * @returns {Promise<void>}
	 * @memberof AuthService
	 */
	public async verifyInvitation(request: VerifyInvitationRequest) : Promise<void>{
		let existingUser = await this.userRepository.findOne({
			where: { email: request.email },
		});

		if (existingUser) {
			throw new NonExistantItemError("User is already registered");
		}

		let user = await this.unverifiedUserRepository.findOne({
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
/**
 * @description This function is a helper function to set the user to a verified user 
 * @param {number} user_id
 * @returns {*} 
 * @memberof AuthService
 */
public async setUserToverified(user_id: number) {
		try {
			await this.unverifiedUserRepository
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
/**
 * @description Helper function to check if given email exists 
 * @param {RegisterRequest} request
 * @returns {*} 
 * @memberof AuthService
 */
public async doesEmailExist(request: RegisterRequest) {
		let emailExists = await this.userRepository.findOne({
			where: { email: request.user_email },
		});

		if (emailExists) return true;

		return false;
	}
/**
 * @description Helper function to check if Username exists 
 * @param {RegisterRequest} request
 * @returns {*} 
 * @memberof AuthService
 */
public async doesUsernameExist(request: RegisterRequest) {
		// check if username and password exist
		let usernameExists = await this.userRepository.findOne({
			where: { username: request.username },
		});

		if (usernameExists) return true;

		return false;
	}
/**
 * @description This function is for educators and student registration 
 * 1. Check if email and username exists 
 * 2. check if the user has been invited to an organisation 
 * 3. set the user details 
 * 4. add subjects that user was invited to their relation
 * 4. Remove user from invited list 
 * @param {RegisterRequest} request
 * @returns  {Promise<void>}
 * @memberof AuthService
 */
public async userRegistration(request: RegisterRequest): Promise<void> {
		// if user name and password don't exist proceed

		if (!(await this.doesEmailExist(request))) {
			if (!(await this.doesUsernameExist(request))) {
				// check if user did verify their number
				let invitedUser = await this.unverifiedUserRepository.findOne({
					where: { email: request.user_email },
					relations: ["subjects", "organisation"],
				});
				// Only invited users can register
				if (invitedUser) {
					if (!invitedUser.verified) {
						throw new NonExistantItemError(
							"User has not been Invited"
						);
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
					if (invitedUser.type == userType.student) {
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
						await this.userRepository.save(user);
					} catch (err) {
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
			} else throw new Error400("Username already exists");
		} else throw new Error400("Email already exists");
	}
/**
 * @description helper function to Check if user exists with specified email address
 * @param {RegisterRequest} request
 * @returns  {Promise<Boolean>}
 * @memberof AuthService
 */
public async emailExists(request: RegisterRequest): Promise<Boolean> {
		
		let emailExists = await this.userRepository.findOne({
			where: { email: request.user_email },
		});
		if (emailExists == undefined) return true;

		return false;
	}
	/**
	 * @description Helper function to Check if user exists with specified email address
	 * @param {RegisterRequest} request
	 * @returns  {Promise<Boolean>}
	 * @memberof AuthService
	 */
	public async usernameExists(request: RegisterRequest) : Promise<Boolean>{
		let usernameExists = await this.userRepository.findOne({
			where: { username: request.username },
		});
		if (usernameExists == undefined) return true;

		return false;
	}
/**
 * @description The purpose of this function is to register the first admin user of an organisation 
 * Check if username and email exists 
 * Check if organisationid givin exists 
 * Set user details 
 * 
 * @param {RegisterRequest} request
 * @returns   {Promise<void>}
 * @memberof AuthService
 */
public async firstAdminRegistration(request: RegisterRequest): Promise<void> {
		let organisation: Organisation;
		if (
			!(await this.doesEmailExist(request)) &&
			!(await this.doesUsernameExist(request))
		) {
			try {
				let org = await this.organisationRepository.findOne(
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
			return this.userRepository
				.save(user)
				.then((result) => {
					return;
				})
				.catch((err) => {
					throw new DatabaseError("User unable to be saved to DB");
				});
		} else {
			throw new Error400("username and email already exist");
		}
	}
}
