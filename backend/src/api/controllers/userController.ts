import express from "express";

//import { RegisterRequest } from "../models/registerRequest";
import { json } from "body-parser";
import { AddUsersToSubjectRequest } from "../interfaces/userInterfaces/AddUsersToSubjectRequest";
import { StudentService } from "../services/StudentService";
import { SetUserToAdminRequest } from "../interfaces/userInterfaces/SetUserToAdminRequet";
import { UserService } from "../services/UserService";
import { RevokeUserFromAdminRequest } from "../interfaces/userInterfaces/RevokeUserFromAdminRequest";
const router = express.Router();

router.use((req, res, next) => {
	next();
});

const service: StudentService = new StudentService();
const userService = new UserService();
router.post("/addUsersToSubject", async (req, res) => {
	let body: AddUsersToSubjectRequest = <AddUsersToSubjectRequest>req.body;
	service.AddUsersToSubject(body).then(() => {
		res.status(200).send("ok");
	});
});

router.post("/setUserToAdmin", async (req, res) => {
	let body: SetUserToAdminRequest = <SetUserToAdminRequest>req.body;
	userService.setUserToAdmin(body).then(() => {
		res.status(200).send("ok");
	});
});

router.post("/revokeUserFromAdmin", async (req, res) => {
	let body: RevokeUserFromAdminRequest = <RevokeUserFromAdminRequest>req.body;
	userService.setUserToAdmin(body).then(() => {
		res.status(200).send("ok");
	});
});
export { router };
