import express from "express";
import { userInfo } from "os";
import passport from "passport";
import { LoginRequest } from "../models/LoginRequest";
import { RegisterRequest } from "../models/RegisterRequest";
import { register, login } from "../service/authService";
const router = express.Router();

router.use((req, res, next) => {
	next();
});

router.get(
	"/protected",
	passport.authenticate("jwt", { session: false }),
	(req, res, next) => {
		res.status(200).json({
			success: true,
			msg: "You are successfully authenticated to this route!",
		});
	}
);
router.post("/login", async (req, res) => {
	login(<LoginRequest>req.body).then((user) => {
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

export { router };
