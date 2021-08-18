import express from "express";
import { AuthController } from "../authController";
import AuthService from "../../services/AuthService";
import { LoginRequest } from "../../../api/models/auth/LoginRequest";
import request from "supertest";
import { app } from "../../../index";
import bodyParser from "body-parser";

jest.mock("../../../api/services/AuthService", () => {
	login: jest.fn();
});
app.use(express.json())
describe("Login Tests", () => {
	it("Log in success", async () => {
		let params: LoginRequest = {
			username: "user",
			password: "test",
		};
		let authserv = new AuthService();
		 let authCont = new AuthController(authserv);
		let response =  
		console.log(response);
		expect(authCont.Login(params)).toThrowError());
	});
});
