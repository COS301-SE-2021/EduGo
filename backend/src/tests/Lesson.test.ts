/* eslint-disable prettier/prettier */
import { anyNumber, anyOfClass, anything, reset, when } from "ts-mockito";
import * as App from "./App";
import * as Default from "./Default";
import request from "supertest";
import { CreateLessonRequest } from "../api/models/lesson/CreateLessonRequest";
import { Lesson } from "../api/database/Lesson";
import { GetLessonsBySubjectRequest } from "../api/models/lesson/GetLessonsBySubjectRequest";
describe("Lesson API tests", () => {
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
		reset(App.mockedLessonRepository);
		reset(App.mockedSubjectRepository); 
		reset(App.mockedUserRepository); 

	});

	describe("POST /lesson/createLesson", () => {
		it("should create a new lesson", async () => {
			const req: CreateLessonRequest = {
				title: "Test Lesson",
				description: "Test Description",
				subjectId: 1,
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

			
			const response = await request(App.app)
				.post("/lesson/createLesson")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send(req)
				.expect(200)
				.expect("Content-Type", /json/);
				expect(response.body.id).toBeDefined();
		});
		it("lesson not found error", async () => {
			const req: CreateLessonRequest = {
				title: "Test Lesson",
				description: "Test Description",
				subjectId: 1,
			};
			when(
				App.mockedSubjectRepository.findOne(anyNumber(), anything())
			).thenResolve(undefined);
			when(
				App.mockedUserRepository.findOne(anyNumber(), anything())
			).thenResolve(Default.educatorUser);

			when(App.mockedUserRepository.findOne(anything())).thenResolve(
				Default.educatorUser
			);
			const response = await request(App.app)
				.post("/lesson/createLesson")
				.set("Accept", "application/json")
				.set("Authorization", educatorToken)
				.send(req)
				.expect(400)
				.expect("Content-Type", /json/);
				//expect(response.body.id).toBeDefined();
		});
	});

	describe("POST /lesson/getLessonsBySubject", ()=> {
		it("subject undefined error", async ()=>{
			const req: GetLessonsBySubjectRequest ={
				subjectId:1
			}

			when(
				App.mockedSubjectRepository.findOne(anyNumber(), anything())
			).thenResolve(undefined);

			when(
				App.mockedUserRepository.findOne(anyNumber(), anything())
			).thenResolve(Default.educatorUser);

			when(App.mockedUserRepository.findOne(anything())).thenResolve(
				Default.educatorUser
			);
			const response = await request(App.app)
			.post("/lesson/getLessonsBySubject")
			.set("Accept", "application/json")
			.set("Authorization", educatorToken)
			.send(req)
			.expect(400)
			.expect("Content-Type", /json/);
			//console.log(response)

		})
		it("should get leesons by subject", async ()=>{
			const req: GetLessonsBySubjectRequest ={
				subjectId:1
			}

			when(
				App.mockedSubjectRepository.findOne(anyNumber(), anything())
			).thenResolve(undefined);

			when(
				App.mockedUserRepository.findOne(anyNumber(), anything())
			).thenResolve(Default.educatorUser);

			when(App.mockedUserRepository.findOne(anything())).thenResolve(
				Default.educatorUser
			);
			const response = await request(App.app)
			.post("/lesson/getLessonsBySubject")
			.set("Accept", "application/json")
			.set("Authorization", educatorToken)
			.send(req)
			.expect(400)
			.expect("Content-Type", /json/);
			//console.log(response)

		})

	})
});
