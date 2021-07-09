import express from "express";

//import { RegisterRequest } from "../models/registerRequest";
import { json } from "body-parser";
import { UserService } from "../service/StudentServiceImplementation";
import { AddUsersToSubjectRequest } from "../models/AddUsersToSubjectRequest";
const router = express.Router();

router.use((req, res, next) => {
	next();
});

const service: UserService = new UserService();

router.post("/addUsersToSubject", async (req, res) => {
	let body: AddUsersToSubjectRequest = <AddUsersToSubjectRequest>req.body;
	service.AddUsersToSubject(body).then(() => {
		res.status(200).send("ok");
	});
});

export { router };
