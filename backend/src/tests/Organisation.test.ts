import { LoginRequest } from "../api/models/auth/LoginRequest";
import { RegisterRequest, userType } from "../api/models/auth/RegisterRequest";
import * as App from "./App";
import request from "supertest";
import * as Default from "./Default";
import { anything, capture, reset, verify, when } from "ts-mockito";
import { VerifyInvitationRequest } from "../api/models/auth/VerifyInvitationRequest";
import { UnverifiedUser } from "../api/database/UnverifiedUser";
import { CreateOrganisationRequest } from "../api/models/organisation/CreateOrganisationRequest";
import { Organisation } from "../api/database/Organisation";

describe("Organisation API tests", () => {
	beforeEach(() => {
		reset(App.mockedUserRepository);
		reset(App.mockedUnverifiedUserRepository);
		reset(App.mockedOrganisationRepository);
	});

	describe("POST /organisation/createOrganisation", () => {
		it("username exists error", async () => {
			const req: CreateOrganisationRequest = {
				organisation_name: "university",
				organisation_email: "uni@gmail.com",
				organisation_phone: "12352346",
				password: "test",
				user_firstName: "jamesp",
				user_lastName: "pearson",
				user_email: "jamesperson.com",
				username: "jamesp",
				organisation_id: 1,
				userType: userType.student,
			};

			when(App.mockedOrganisationRepository.save(anything())).thenResolve(
				Default.eduGoOrg
			);
			when(App.mockedUserRepository.findOne(anything()))
				.thenResolve(Default.adminUser)
				.thenResolve(undefined);

			const response = await request(App.app)
				.post("/organisation/createOrganisation")
				.set("Accept", "application/json")
				.send(req)
				.expect(400)
				.expect("Content-Type", /json/);
			//console.log(response);
			//expect(response.body.token).toBeDefined();
		});

		it("email exists error", async () => {
			const req: CreateOrganisationRequest = {
				organisation_name: "university",
				organisation_email: "uni@gmail.com",
				organisation_phone: "12352346",
				password: "test",
				user_firstName: "jamesp",
				user_lastName: "pearson",
				user_email: "jamesperson.com",
				username: "jamesp",
				organisation_id: 1,
				userType: userType.student,
			};

			when(App.mockedOrganisationRepository.save(anything())).thenResolve(
				Default.eduGoOrg
			);
			when(App.mockedUserRepository.findOne(anything()))
				.thenResolve(undefined)
				.thenResolve(Default.adminUser);

			const response = await request(App.app)
				.post("/organisation/createOrganisation")
				.set("Accept", "application/json")
				.send(req)
				.expect(400)
				.expect("Content-Type", /json/);
			//console.log(response);
			//expect(response.body.token).toBeDefined();
		});
		it("Organisation not found error ", async () => {
			const req: CreateOrganisationRequest = {
				organisation_name: "university",
				organisation_email: "uni@gmail.com",
				organisation_phone: "12352346",
				password: "test",
				user_firstName: "jamesp",
				user_lastName: "pearson",
				user_email: "jamesperson.com",
				username: "jamesp",
				organisation_id: 1,
				userType: userType.student,
			};

			when(App.mockedOrganisationRepository.save(anything())).thenResolve(
				Default.eduGoOrg
			);

			when(
				App.mockedOrganisationRepository.findOne(anything())
			).thenResolve(undefined);
			when(App.mockedUserRepository.findOne(anything()))
				.thenResolve(undefined)
				.thenResolve(undefined);

			const response = await request(App.app)
				.post("/organisation/createOrganisation")
				.set("Accept", "application/json")
				.send(req)
				.expect(404)
				.expect("Content-Type", /json/);
			//console.log(response);
			//expect(response.body.token).toBeDefined();
		});
		
		
	});
});
