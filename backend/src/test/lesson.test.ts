import { createConnection } from "typeorm";

import { app } from "../index";
import supertest from "supertest";

describe("Testing if tests work", () => {
	it("ping server", async () => {
		await supertest(app).get("/").expect(200);
	});
});
