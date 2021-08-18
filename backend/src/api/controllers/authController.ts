import { ok } from "assert/strict";
import express from "express";
import passport from "passport";
import { LoginRequest } from "../models/auth/LoginRequest";
import { RegisterRequest } from "../models/auth/RegisterRequest";
import { VerifyInvitationRequest } from "../models/auth/VerifyInvitationRequest";
import AuthService from "../services/AuthService";
import { Container, Inject, Service } from "typedi";
import { Body, JsonController, Post } from "routing-controllers";

@Service()
@JsonController("/auth")
export class AuthController {
	constructor(@Inject() private service: AuthService) {}

	@Post("/login")
	Login(@Body({ required: true }) body: LoginRequest) {
		return this.service.login(body);
	}

	@Post("/register")
	Register(@Body({ required: true }) body: RegisterRequest) {
		return this.service.register(body);
	}

	@Post("/verifyInvitation")
	VerifyInvitation(@Body({ required: true }) body: VerifyInvitationRequest) {
		return this.service.verifyInvitation(body);
	}
}
