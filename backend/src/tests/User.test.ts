/* eslint-disable prettier/prettier */
import { anyNumber, anyOfClass, anything, reset, when } from "ts-mockito";
import * as App from "./App";
import * as Default from "./Default";
import request from "supertest";
import { CreateLessonRequest } from "../api/models/lesson/CreateLessonRequest";
import { Lesson } from "../api/database/Lesson";
import { GetLessonsBySubjectRequest } from "../api/models/lesson/GetLessonsBySubjectRequest";
import { AddVirtualEntityToLessonRequest } from "../api/models/lesson/AddVirtualEntityToLessonRequest";
import { CreateSubjectRequest } from "../api/models/subject/CreateSubjectRequest";
import { DeleteSubjectRequest } from "../api/models/subject/DeleteSubjectRequest";
import { SetUserToAdminRequest } from "../api/models/user/SetUserToAdminRequet";
import { AddStudentsToSubjectRequest } from "../api/models/user/AddStudentToSubjectRequest";
import { In } from "typeorm";
describe("User API tests", () => {
	let educatorToken = "";
	beforeAll(async () => {
		when(App.mockedUserRepository.findOne(anything())).thenResolve(
			Default.adminUser
		);
		const educatorResponse = await request(App.app)
			.post("/auth/login")
			.set("Accept", "application/json")
			.send({ username: "admin", password: "password" });
		educatorToken = educatorResponse.body.token;
	});

	beforeEach(() => {
		reset(App.mockedLessonRepository);
		reset(App.mockedSubjectRepository); 
		reset(App.mockedUserRepository); 
		reset(App.mockedVirtualEntityRepository); 
		when(
			App.mockedUserRepository.findOne(anyNumber(), anything())
		).thenResolve(Default.adminUser);

		when(App.mockedUserRepository.findOne(anything())).thenResolve(
			Default.educatorUser
		);
		when(
			App.mockedSubjectRepository.findOne(anyNumber(), anything())
		).thenResolve(Default.subjects[0]);

		when(
			App.mockedLessonRepository.save(anyOfClass(Lesson))
		).thenResolve({ id: 1 });


	});

	describe("POST /user/setUserToAdmin", () => {
		it("should set user to admin", async () => {
			const req: SetUserToAdminRequest = {
				username: "simadmin"
			};

			when(
				App.mockedUserRepository.findOne( anything())
			).thenResolve(Default.educatorUser);
			
			const response = await request(App.app)
				.post("/user/setUserToAdmin")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send(req)
				.expect(200)
			//	.expect("Content-Type", /json/);
				//expect(response.body.id).toBeDefined();
			//	console.log(response)
		});
		it("should fail to set user to admin ", async () => {
			const req: SetUserToAdminRequest = {
				username: "simadmin"
			};

			when(
				App.mockedUserRepository.findOne( anything())
			).thenResolve(Default.studentUser);
			
			const response = await request(App.app)
				.post("/user/setUserToAdmin")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send(req)
				.expect(403)
			//	.expect("Content-Type", /json/);
				//expect(response.body.id).toBeDefined();
			//	console.log(response)
		});
		
	});

	describe("POST /user/revokeUserFromAdmin", () => {
		it("should revoke User From Admin", async () => {
			const req: DeleteSubjectRequest = {
				id: 1
			};
			when(
				App.mockedUserRepository.findOne( anything())
			).thenResolve(Default.adminUser);

			const response = await request(App.app)
				.delete("/subject/deleteSubject")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send(req)
				.expect(200)
			//	.expect("Content-Type", /json/);
			//	expect(response.body.id).toBeDefined();
			//console.log(response)

		});
		it("should revoke User From Admin", async () => {
			const req: DeleteSubjectRequest = {
				id: 1
			};
			when(
				App.mockedUserRepository.findOne( anything())
			).thenResolve(Default.educatorUser);

			const response = await request(App.app)
				.delete("/subject/deleteSubject")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send(req)
				.expect(200)
			//	.expect("Content-Type", /json/);
			//	expect(response.body.id).toBeDefined();
			//console.log(response)

		});
		
	});

	describe("POST /user/addStudentsToSubject", () => {
		it("should add Students To Subject", async () => {
			const req: AddStudentsToSubjectRequest = {
			students: ["simk@gmail.com", "sthe@gmail.com"], 
			subject_id: 1
			};

					
			when(
				App.mockedUserRepository.find({
					where: { email: In(anything()) },
				})
			).thenResolve([Default.studentUser]);
			when(
				App.mockedUserRepository.findOne(anything(), anything())
			).thenResolve(Default.educatorUser);
			when(
				App.mockedUnverifiedUserRepository.find({
					where: { email: In(anything()) },
				})
			).thenResolve([Default.unverifiedEducator]);
	
			const response = await request(App.app)
				.post("/user/addStudentsToSubject")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send(req)
				//.expect(200)
			//	.expect("Content-Type", /json/);
				//expect(response.body.id).toBeDefined();
				//console.log(response)

		});
		
	});

	describe("GET /user/getUserDetails", () => {
		it("should get User Details", async () => {
			
			when(
				App.mockedUserRepository.findOne(anyNumber(), anything())
			).thenResolve(Default.educatorUser);
			when(
				App.mockedUserRepository.find({
					where: { email: In(anything()) },
					relations: anything(),
				})
			).thenResolve([Default.educatorUser]);

			when(
				App.mockedUserRepository.find({
					where: { email: In(anything()) },
				})
			).thenResolve([Default.educatorUser]);


			const response = await request(App.app)
				.get("/user/getUserDetails")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send()
				.expect(200)
			//	.expect("Content-Type", /json/);
				//expect(response.body.id).toBeDefined();
				//console.log(response)

		});
		

		it("should get User Details", async () => {
			
			when(
				App.mockedUserRepository.findOne(anyNumber(), anything())
			).thenResolve(undefined);
			when(
				App.mockedUserRepository.find({
					where: { email: In(anything()) },
					relations: anything(),
				})
			).thenResolve([Default.educatorUser]);

			when(
				App.mockedUserRepository.find({
					where: { email: In(anything()) },
				})
			).thenResolve([Default.educatorUser]);


			const response = await request(App.app)
				.get("/user/getUserDetails")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send()
				.expect(401)
			//	.expect("Content-Type", /json/);
				//expect(response.body.id).toBeDefined();
				//console.log(response)

		});
	});
	describe("GET /user/getStudentGrades", () => {
		it("should get Student Grades", async () => {
			
			when(
				App.mockedUserRepository.findOne(anything(), anything())
			).thenResolve(Default.studentUser);
			
			const response = await request(App.app)
				.get("/user/getStudentGrades")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send()
				//.expect(200)
			//	.expect("Content-Type", /json/);
				//expect(response.body.id).toBeDefined();

			//	console.log(response)

		});
		
	});
	describe("POST /user/getGradesByEducator", () => {
		it("should get Grades By Educator", async () => {
			
			when(
				App.mockedUserRepository.findOne(anyNumber(), anything())
			).thenResolve(Default.educatorUser);
			
			const response = await request(App.app)
				.get("/user/getGradesByEducator")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send()
				.expect(200)
			//	.expect("Content-Type", /json/);
				//expect(response.body.id).toBeDefined();
				//console.log(response)

		});
		it("should fail to get Grades By Educator", async () => {
			
			when(
				App.mockedUserRepository.findOne(anyNumber(), anything())
			).thenResolve(Default.educatorUser);
			
			const response = await request(App.app)
				.get("/user/getGradesByEducator")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send()
				.expect(200)
			//	.expect("Content-Type", /json/);
				//expect(response.body.id).toBeDefined();
				//console.log(response)

		});
		
	});


});
