import express from "express";
import { handleErrors } from "../helper/ErrorCatch";
import { isUser, isAdmin, passportJWT } from "../middleware/validate";
import { LoginRequest } from "../models/auth/LoginRequest";
import { RegisterRequest } from "../models/auth/RegisterRequest";
import { VerifyInvitationRequest } from "../models/auth/VerifyInvitationRequest";
import { AuthService } from "../services/AuthService";

const service = new AuthService();
const router = express.Router();

router.use((req, res, next) => {
	next();
});

router.get("/protected", passportJWT, isUser, (req, res, next) => {
	res.status(200).json({
		success: true,
		msg: "You are successfully authenticated  as a user to this route!",
	});
});

router.get("/protectedAdmin", passportJWT, isAdmin, (req, res, next) => {
	res.status(200).json({
		success: true,
		msg: "You are successfully as an admin to this route!",
	});
});
router.post("/login", async (req, res) => {
	service
		.login(<LoginRequest>req.body)
		.then((response) => {
			res.status(200).json(response);
		})
		.catch((err) => {
			console.log(err);
		});
});

router.post("/register", async (req, res) => {
	service
		.register(<RegisterRequest>req.body)
		.then((response) => {
			res.status(200).json(response);
		})
		.catch((err) => {
			handleErrors(err, res);
		});
});

router.post("/verifyInvitation", async (req, res) => {
	service
		.verifyInvitation(<VerifyInvitationRequest>req.body)
		.then((response) => {
			res.status(200).json(response);
		})
		.catch((err) => {
			handleErrors(err, res);
		});
});

export { router };
