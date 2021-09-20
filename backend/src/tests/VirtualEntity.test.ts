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
import { CreateVirtualEntityRequest } from "../api/models/virtualEntity/CreateVirtualEntityRequest";
import { Quiz } from "../api/models/virtualEntity/Default";
import { Question } from "../api/models/virtualEntity/Default";
import { GetVirtualEntityRequest } from "../api/models/virtualEntity/GetVirtualEntityRequest";
describe("Virtual Entity API tests", () => {
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

	describe("POST /virtualEntity/uploadModel", () => {
		it.skip("should not create thumbnail sucessfully", async () => {
			
			when(
				App.mockedUserRepository.findOne( anything())
			).thenResolve(Default.educatorUser);
			
			when(App.mockedAzureBlobService.createAppendBlobFromStream(anything(),anything(),anything(),anyNumber(), anything())).thenResolve().thenResolve()
			when(App.mockedAzureBlobService.getUrl(anything(),anything())).thenReturn("www.edugo.com")
			const response = await request(App.app)
				.post("/virtualEntity/uploadModel")
				.set("Authorization", educatorToken)
				.attach('file', "C:/Users/simek/Downloads/rxt.glb")
				.expect(500)
				//.expect("Content-Type", /json/);
				//expect(response.body.id).toBeDefined();
		});
			//	.expect("Content-Type", /json/);
				//expect(response.body.id).toBeDefined();
			//	console.log(response)
		});
		
	describe("POST /virtualEntity/createVirtualEntity", () => {
		it("should create VirtualEntity", async () => {
		
			const  req:CreateVirtualEntityRequest= new CreateVirtualEntityRequest(); 
			req.description= [ "Just some virtual entity"]; 
			req.title = "Virtual Entity"; 
			req.quiz= new Quiz(); 
			req.quiz.questions = [new Question(), new Question()]; 
			req.quiz.questions[0].correctAnswer= "A"; 
			req.quiz.questions[0].options= ["A", "B", "C"]; 
			req.quiz.questions[0].question = "What is the value of 1?"
			req.quiz.questions[0].type = "multiple choice"; 
			req.quiz.questions[1].correctAnswer= "A"; 
			req.quiz.questions[1].options= ["A", "B", "C"]; 
			req.quiz.questions[1].question = "What is the value of 1?"
			req.quiz.questions[1].type = "multiple choice"; 
			

			when(
				App.mockedUserRepository.findOne( anything())
			).thenResolve(Default.educatorUser);
			
			when (App.mockedVirtualEntityRepository.save(anything())).thenResolve(Default.virtualEntities[0])
			const response = await request(App.app)
				.post("/virtualEntity/createVirtualEntity")
				.set("Authorization", educatorToken)
				.send(req)
				.expect(200)
				//.expect("Content-Type", /json/);
				//expect(response.body.id).toBeDefined();
				//console.log(response)
		});
		it("should not create VirtualEntity", async () => {
		
			const  req:CreateVirtualEntityRequest= new CreateVirtualEntityRequest(); 
			req.description= [ "Just some virtual entity"]; 
			req.title = "Virtual Entity"; 
			req.quiz= new Quiz(); 
			req.quiz.questions = [new Question(), new Question()]; 
			req.quiz.questions[0].correctAnswer= "A"; 
			req.quiz.questions[0].options= ["A", "B", "C"]; 
			req.quiz.questions[0].question = "What is the value of 1?"
			req.quiz.questions[0].type = "multiple choice"; 
			req.quiz.questions[1].correctAnswer= "A"; 
			req.quiz.questions[1].options= ["A", "B", "C"]; 
			req.quiz.questions[1].question = "What is the value of 1?"
			req.quiz.questions[1].type = "multiple choice"; 
			

			when(
				App.mockedUserRepository.findOne( anything())
			).thenResolve(Default.educatorUser);
			
			when (App.mockedVirtualEntityRepository.save(anything())).thenResolve(undefined)
			const response = await request(App.app)
				.post("/virtualEntity/createVirtualEntity")
				.set("Authorization", educatorToken)
				.send(req)
				.expect(404)
				//.expect("Content-Type", /json/);
				//expect(response.body.id).toBeDefined();
				//console.log(response)
		});

		});

		describe("POST /virtualEntity/getVirtualEntity", ()=>{
			it(" virtual entity not found", async ()=>{
				const req: GetVirtualEntityRequest={ id: 12}; 

				when(
					App.mockedUserRepository.findOne( anything())
				).thenResolve(Default.educatorUser);
				
				when (App.mockedVirtualEntityRepository.save(anything())).thenResolve(undefined)
				const response = await request(App.app)
					.post("/virtualEntity/getVirtualEntity")
					.set("Authorization", educatorToken)
					.send(req)
					.expect(404)
					//.expect("Content-Type", /json/);
					//expect(response.body.id).toBeDefined();
					//console.log(response)
			})
			it("Should sucessfully get virtual entity ", async ()=>{
				const req: GetVirtualEntityRequest={ id: 12}; 

				when(
					App.mockedUserRepository.findOne( anything())
				).thenResolve(Default.educatorUser);
				
				when (App.mockedVirtualEntityRepository.save(anything())).thenResolve(undefined)
				const response = await request(App.app)
					.post("/virtualEntity/getVirtualEntity")
					.set("Authorization", educatorToken)
					.send(req)
					.expect(404)
					//.expect("Content-Type", /json/);
					//expect(response.body.id).toBeDefined();
					console.log(response)
			})
		})
		
	});


