import express from "express";
import { isUser, isAdmin, passportJWT } from "../middleware/rules";
import { LoginRequest } from "../interfaces/authInterfaces/LoginRequest";
import { RegisterRequest } from "../interfaces/authInterfaces/RegisterRequest";
import { VerifyInvitationRequest } from "../interfaces/authInterfaces/VerifyInvitationRequest";
import { register, login, verifyInvitation } from "../services/authService";
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
	login(<LoginRequest>req.body)
		.then((user) => {
			if (user) {
				if (user.type == "success") {
					res.status(200);
					res.json(user);
				} else {
					res.status(400);
					res.json(user);
				}
			}
		})
		.catch((err) => {
			console.log(err);
		});
});

router.post("/register", async (req, res) => {
	register(<RegisterRequest>req.body)
		.then((user) => {
			if (user) {
				if (user.type == "success") {
					res.status(200);
					res.json(user);
				} else {
					res.status(400);
					res.json(user);
				}
			}
		})
		.catch((err) => {
			console.log(err);
		});
});

router.post("/verifyInvitation", async (req, res) => {
	verifyInvitation(<VerifyInvitationRequest>req.body)
		.then((user) => {
			if (user) {
				if (user.type == "success") {
					res.status(200);
					res.json(user);
				} else {
					res.status(400);
					res.json(user);
				}
			}
		})
		.catch((err) => {
			console.log(err);
		});
});

export { router };
