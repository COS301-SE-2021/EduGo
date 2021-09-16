import "reflect-metadata";
import { User } from "../../../../api/database/User";
import { anything, instance, mock, reset, verify, when } from "ts-mockito";
import { Repository } from "typeorm";
import { UnverifiedUser } from "../../../../api/database/UnverifiedUser";
import { Organisation } from "../../../database/Organisation";
import { AuthController } from "../../authController";
import AuthService from "../../../../api/services/AuthService";
import { LoginRequest } from "../../../../api/models/auth/LoginRequest";
import {
	BadRequestError,
	NotFoundError,
	UnauthorizedError,
} from "routing-controllers";
import { VerifyInvitationRequest } from "../../../../api/models/auth/VerifyInvitationRequest";
import {
	RegisterRequest,
	userType,
} from "../../../../api/models/auth/RegisterRequest";

const mockedUserRepo: Repository<User> = mock(Repository);
const userRepo: Repository<User> = instance(mockedUserRepo);

const mockedUnverifiedRepo: Repository<UnverifiedUser> = mock(Repository);
const unverifiedRepo: Repository<UnverifiedUser> =
	instance(mockedUnverifiedRepo);
const mockedOrgRepo: Repository<Organisation> = mock(Repository);
const orgRepo: Repository<Organisation> = instance(mockedOrgRepo);

const authService: AuthService = new AuthService(
	userRepo,
	unverifiedRepo,
	orgRepo
);
const authController: AuthController = new AuthController(authService);

describe("Auth controller integration tests", () => {
	beforeEach(() => {
		reset(mockedOrgRepo);
		reset(mockedUnverifiedRepo);
		reset(mockedUserRepo);
	});

	describe("Login ", () => {
		it("Unsucessfull login ", async () => {
			const request: LoginRequest = {
				username: "test",
				password: "test",
			};

			when(mockedUserRepo.findOne(anything())).thenResolve(undefined);
			await expect(() => authController.Login(request)).rejects.toThrow(
				UnauthorizedError
			);
			//verify(mockedUserRepo.findOne(anything(), anything())).once();
		});
	});

	describe("Verify Invitation", () => {
		it("User Already exists error", async () => {
			const request: VerifyInvitationRequest = {
				email: "simek ",
				verificationCode: "2346",
			};
			when(mockedUserRepo.findOne(anything())).thenResolve(new User());

			//when(mockedUnverifiedRepo.findOne(anything())).thenResolve(undefined)
			await expect(() =>
				authController.VerifyInvitation(request)
			).rejects.toThrow(NotFoundError);
		});

		it("User Has not been invited error", async () => {
			const request: VerifyInvitationRequest = {
				email: "simek ",
				verificationCode: "2346",
			};
			when(mockedUserRepo.findOne(anything())).thenResolve(undefined);

			when(mockedUnverifiedRepo.findOne(anything())).thenResolve(
				undefined
			);
			await expect(() =>
				authController.VerifyInvitation(request)
			).rejects.toThrow(BadRequestError);
		});
		it("Incorrect invitation code was given", async () => {
			const request: VerifyInvitationRequest = {
				email: "simek ",
				verificationCode: "2346",
			};
			when(mockedUserRepo.findOne(anything())).thenResolve(undefined);

			when(mockedUnverifiedRepo.findOne(anything())).thenResolve(
				new UnverifiedUser()
			);
			await expect(() =>
				authController.VerifyInvitation(request)
			).rejects.toThrow(BadRequestError);
		});
	});
	describe("user registration ", () => {
		it("Username already exists", async () => {
			const request: RegisterRequest = {
				password: "test",
				user_firstName: "simk",
				user_lastName: "mab",
				username: "simk",
				user_email: "simekani.mabambe@gmail.com",
				userType: userType.educator,
				organisation_id: 0,
			};

			when(mockedUserRepo.findOne(anything())).thenResolve(new User());
			await expect(() =>
				authController.Register(request)
			).rejects.toThrow(BadRequestError);
		});

		it("User has not been invited to organisation", async () => {
			const request: RegisterRequest = {
				password: "test",
				user_firstName: "simk",
				user_lastName: "mab",
				username: "simk",
				user_email: "simekani.mabambe@gmail.com",
				userType: userType.educator,
				organisation_id: 0,
			};

			when(mockedUserRepo.findOne(anything())).thenResolve(undefined);
			when(mockedUnverifiedRepo.findOne(anything())).thenResolve(
				undefined
			);
			await expect(() =>
				authController.Register(request)
			).rejects.toThrow(NotFoundError);
		});
	});
});
