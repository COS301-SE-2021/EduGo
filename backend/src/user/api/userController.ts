import express from "express";
import { register } from "../service/userService";
import { RegisterRequest } from "../models/registerRequest";
import { json } from "body-parser";
const router = express.Router();

router.use((req, res, next) => {
	next();
});

router.get("/protected", async (req, res, next) => {});

router.post("/login", async (req, res) => {});

router.post("/register", async (req, res) => {
	register(<RegisterRequest>req.body).then((result) => {
		if (result?.type == "success") {
			res.json(result);
			res.status(200);
		}
	});
});

export { router };
