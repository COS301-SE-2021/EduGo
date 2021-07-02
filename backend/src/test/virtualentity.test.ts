import { createConnection } from "typeorm";

import { app } from "../index";
import supertest from "supertest";

describe("Testing if tests work", () => {
	it("Should pass", () => {
		let i = 2 + 10;
		expect(i).toBe(12);
	});

	it("ping server", async () => {
		await supertest(app).get("/").expect(200);
	});
});
