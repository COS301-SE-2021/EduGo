import { createConnection, getConnection } from "typeorm";

import { app } from "../index";
import request from "supertest";
import { Lesson } from "../database/entity/Lesson";
import { Subject } from "../database/entity/Subject";
import { validateCreatelessRequest } from "../lesson/validate";

beforeAll(async () => {
	await createConnection({
		type: "postgres",
		host: "db",
		port: 5432,
		username: process.env.DB_USER,
		password: process.env.DB_PASSWORD,
		database: "test",
		synchronize: true,
		logging: false,
		entities: ["src/database/entity/**/*.ts"],
		migrations: ["src/database/migration/**/*.ts"],
		subscribers: ["src/database/subscriber/**/*.ts"],
		cli: {
			entitiesDir: "src/database/entity",
			migrationsDir: "src/database/migration",
			subscribersDir: "src/database/subscriber",
		},
	});

	let sampleLesson: Lesson = new Lesson();
	sampleLesson.title = "Test Lesson";
	sampleLesson.description = "Just a test";
	sampleLesson.date = "21/06/2021";

	let sampleSubject: Subject = new Subject();
	sampleSubject.title = "Test Subject";
	sampleSubject.description = "Just a test";
	sampleSubject.educatorId = 1;
	sampleSubject.grade = 12;
	sampleSubject.lessons = [sampleLesson];

	await getConnection().getRepository(Subject).save(sampleSubject);
});

afterAll(async () => {
	await getConnection().close();
	console.log("closed");
});

describe("Create subject", () => {
	test("If basic create subject validation passes", () => {
		let data = {
			subjectId: 1,
			title: "",
			description: "",
			date: "",
		};

		let result = validateCreatelessRequest(data);
		expect(result.ok).toBe(true);
	});

	test("If incorrect basic create subject validation passes", () => {
		let data = {
			subjectId: 1,
			title: "",
		};

		let result = validateCreatelessRequest(data);
		expect(result.ok).toBe(false);
		expect(result.message).toContain("");
	});

	test("If new subject is successfully created", async () => {
		const response = await request(app)
			.post("/subject/createSubject")
			.send({
				subjectId: 1,
				description: "Some subject description",
				title: "Edugo subject",
				date: "20 june",
			});
		expect(response.statusCode).toBe(200);
	});

	test("If new subject is not successfully created due to invalid request body", async () => {
		const response = await request(app)
			.post("/subject/createSubject")
			.send({
				subjectIdsss: 1,
				description: "Some subject description",
				title: "Edugo subject",
				date: "20 june",
			});
		expect(response.statusCode).toBe(200);
	});
});
