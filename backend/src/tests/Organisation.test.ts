import { LoginRequest } from "../api/models/auth/LoginRequest";
import { RegisterRequest, userType } from "../api/models/auth/RegisterRequest";
import * as App from "./App";
import request from "supertest";
import * as Default from "./Default";
import { anything, capture, reset, verify, when } from "ts-mockito";
import { VerifyInvitationRequest } from "../api/models/auth/VerifyInvitationRequest";
import { UnverifiedUser } from "../api/database/UnverifiedUser";
import { CreateOrganisationRequest } from "../api/models/organisation/CreateOrganisationRequest";

describe("Organisation API tests", () => {
	beforeEach(() => {
		reset(App.mockedUserRepository);
		reset(App.mockedUnverifiedUserRepository);
	});

	describe("POST /organisation/createOrganisation", () => {
		it("should successfully login a student and return a token", async () => {
			const req: CreateOrganisationRequest = {
				organisation_name: "",
				organisation_email: "",
				organisation_phone: "",
				password: "",
				user_firstName: "",
				user_lastName: "",
				user_email: "",
				username: "",
				organisation_id: 1,
				userType: userType.firstAdmin
			};

			when(App.mockedUserRepository.findOne(anything())).thenResolve(
				Default.studentUser
			);

			const response = await request(App.app)
				.post("/organisation/createOrganisation")
				.set("Accept", "application/json")
				.send(req)
				.expect(200)
				.expect("Content-Type", /json/);

			expect(response.body.token).toBeDefined();
		});
	});
});
