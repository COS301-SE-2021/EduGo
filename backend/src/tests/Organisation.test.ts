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
import { GetOrganisationResponse } from "../api/models/organisation/GetOrganisationResponse";
import { GetOrganisationRequest } from "../api/models/organisation/GetOrganisationRequest";
import { In } from "typeorm";
import { BadRequestError } from "routing-controllers";

describe("Organisation API tests", () => {
	let educatorToken = "";
	beforeAll(async () => {
		when(App.mockedUserRepository.findOne(anything())).thenResolve(
			Default.educatorUser
		);
		const educatorResponse = await request(App.app)
			.post("/auth/login")
			.set("Accept", "application/json")
			.send({ username: "educator", password: "password" });
		educatorToken = educatorResponse.body.token;
	});

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

		it("unable to save user error", async () => {
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
			when(App.mockedUserRepository.save(anything())).thenThrow(
				new Error()
			);

			when(
				App.mockedOrganisationRepository.findOne(anything())
			).thenResolve(Default.eduGoOrg);
			when(App.mockedUserRepository.findOne(anything()))
				.thenResolve(undefined)
				.thenResolve(undefined);

			const response = await request(App.app)
				.post("/organisation/createOrganisation")
				.set("Accept", "application/json")
				.send(req)
				.expect(500)
				.expect("Content-Type", /json/);
			//console.log(response);
			//expect(response.body.token).toBeDefined();
		});
		it("Created Organisation succesfully ", async () => {
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
			).thenResolve(Default.eduGoOrg);
			when(App.mockedUserRepository.findOne(anything()))
				.thenResolve(undefined)
				.thenResolve(undefined);

			const response = await request(App.app)
				.post("/organisation/createOrganisation")
				.set("Accept", "application/json")
				.send(req)
				.expect(200)
				.expect("Content-Type", /json/);
			//console.log(response);
			//expect(response.body.token).toBeDefined();
		});
	});

	it("Created Organisation succesfully ", async () => {
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

		when(App.mockedOrganisationRepository.findOne(anything())).thenResolve(
			Default.eduGoOrg
		);
		when(App.mockedUserRepository.findOne(anything()))
			.thenResolve(undefined)
			.thenResolve(undefined);

		const response = await request(App.app)
			.post("/organisation/createOrganisation")
			.set("Accept", "application/json")
			.send(req)
			.expect(200)
			.expect("Content-Type", /json/);
		//console.log(response);
		//expect(response.body.token).toBeDefined();
	});

	describe("POST /organisation/getOrganisation", () => {
		it("organisation not found error", async () => {
			when(
				App.mockedOrganisationRepository.findOne(anything(), anything())
			).thenResolve(undefined);
			when(
				App.mockedUserRepository.find({
					where: { id: In(anything()) },
					relations: [anything()],
				})
			).thenResolve([Default.educatorUser]);

			const req: GetOrganisationRequest = { id: 1 };
			const response = await request(App.app)
				.post("/organisation/getOrganisation")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send(req)
				.expect(400)
				.expect("Content-Type", /json/);
			//console.log(response);
		});
		it.skip("successfully get organisation", async () => {
			when(
				App.mockedOrganisationRepository.findOne(anything(), anything())
			).thenResolve(Default.eduGoOrg);

			const req: GetOrganisationRequest = { id: 1 };
			const response = await request(App.app)
				.post("/organisation/getOrganisation")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send(req);
			//.expect(200)
			//.expect("Content-Type", /json/);
			console.log(response);
		});
	});

	describe("POST /organisation/getOrganisations", () => {
		it("organisations returned", async () => {
			when(App.mockedOrganisationRepository.find()).thenResolve([
				Default.eduGoOrg,
			]);
			const response = await request(App.app)
				.post("/organisation/getOrganisations")
				.set("Accept", "application/json")
				.expect(200)
				.expect("Content-Type", /json/);
			//console.log(response);
		});
		it("organisations not returned", async () => {
			when(App.mockedOrganisationRepository.find()).thenThrow(
				new BadRequestError("errr")
			);
			const response = await request(App.app)
				.post("/organisation/getOrganisations")
				.set("Accept", "application/json")
				.expect(400)
				.expect("Content-Type", /json/);
			//console.log(response);
		});
	});
});
