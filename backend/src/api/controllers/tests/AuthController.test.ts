import express from "express";
import { AuthController } from "../authController";
import  AuthService  from "../../../api/services/AuthService";
import { LoginRequest } from "../../../api/models/auth/LoginRequest";
import request from "supertest";
import { app } from "../../../index";

jest.mock("../../../api/services/AuthService", ()=>{
    login: jest.fn()
})

describe("Login Tests", () => {
	it("Log in success", async () => {
		let params: LoginRequest = {
			username: "user",
			password: "test",
		};

        let authserv = new AuthService(); 

        let authCont = new AuthController(authserv); 
        
		let body = await request(app).post("/auth/login").send(params);
		console.log(body);
	});
});
