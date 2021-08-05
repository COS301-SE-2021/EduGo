import { ok } from "assert/strict";
import express from "express";
import passport from "passport";
import { handleErrors } from "../helper/ErrorCatch";
import { LoginRequest } from "../models/auth/LoginRequest";
import { RegisterRequest } from "../models/auth/RegisterRequest";
import { VerifyInvitationRequest } from "../models/auth/VerifyInvitationRequest";
import { AuthService } from "../services/AuthService";
import { Container } from "typedi";

const service = Container.get(AuthService);
const router = express.Router();

router.use((req, res, next) => {
	next();
});

router.post("/login", async (req, res) => {
	service
		.login(<LoginRequest>req.body)
		.then((response) => {
			res.status(200).json(response);
		})
		.catch((err) => {
			handleErrors(err, res);
		});
});


router.post("/register", async (req, res) => {
	service
		.register(<RegisterRequest>req.body)
		.then((response) => {
			res.status(200).send("ok");
		})
		.catch((err) => {
			handleErrors(err, res);
		});
});

router.post("/verifyInvitation", async (req, res) => {
	service
		.verifyInvitation(<VerifyInvitationRequest>req.body)
		.then((response) => {
			res.status(200).send("ok");
		})
		.catch((err) => {
			handleErrors(err, res);
		});
});

export { router };
