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
import { Subject } from "../api/database/Subject";
describe("Subject API tests", () => {
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
		).thenResolve(Default.educatorUser);

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

	describe("POST /subject/createSubject", () => {
		it("should create a new Subject", async () => {
			const req: CreateSubjectRequest = {
				grade:1, 
				title:"Test Subject"
			};
			when(
				App.mockedUserRepository.findOne(anyNumber(), anything())
			).thenResolve(Default.educatorUser);

			when(
				App.mockedSubjectRepository.save(anyOfClass(Subject))
			).thenResolve({ id: 1 });

			when(App.mockedAzureBlobService.createAppendBlobFromStream(anything(),anything(),anything(),anyNumber(), anything())).thenResolve().thenResolve()
			when(App.mockedAzureBlobService.getUrl(anything(),anything())).thenReturn("www.edugo.com")
			const response = await request(App.app)
				.post("/subject/createSubject")
				.set("Authorization", educatorToken)
				.field("grade", req.grade)
				.field("title", req.title)
				.attach('file', "C:/Users/simek/Downloads/output-onlinepngtools.png")
				.expect(200)
				.expect("Content-Type", /json/);
				expect(response.body.id).toBeDefined();
		});
		
	});

	describe("POST /subject/deleteSubject", () => {
		it("should delete a Subject", async () => {
			const req: DeleteSubjectRequest = {
				id: 1
			};
			when(
				App.mockedUserRepository.findOne(anyNumber(), anything())
			).thenResolve(Default.educatorUser);

			when(App.mockedUserRepository.findOne(anything())).thenResolve(
				Default.educatorUser
			);
			when(
				App.mockedSubjectRepository.findOne(anyNumber(), anything())
			).thenResolve(Default.subjects[0]);

			when(
				App.mockedLessonRepository.save(anyOfClass(Lesson))
			).thenResolve({ id: 1 });

			when(
				App.mockedSubjectRepository.delete(anything())
			).thenResolve();

			const response = await request(App.app)
				.delete("/subject/deleteSubject")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send(req)
			//	.expect(200)
			//	.expect("Content-Type", /json/);
			//	expect(response.body.id).toBeDefined();
			//console.log(response)

		});
		
	});

	describe("POST /subject/getSubjectsByUser", () => {
		it("should Get Subjects of users", async () => {
			const req: CreateSubjectRequest = {
				grade:1, 
				title:"Test Subject"
			};

			
			when(
				App.mockedUserRepository.findOne(anyNumber(), anything())
			).thenResolve(Default.educatorUser);
			
			const response = await request(App.app)
				.post("/subject/getSubjectsByUser")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send(req)
				.expect(200)
			//	.expect("Content-Type", /json/);
				//expect(response.body.id).toBeDefined();
				//console.log(response)

		});
		
	});

});
