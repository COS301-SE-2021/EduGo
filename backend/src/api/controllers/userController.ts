import express from "express";

//import { RegisterRequest } from "../models/registerRequest";
import { StudentService } from "../services/StudentService";
import { SetUserToAdminRequest } from "../models/user/SetUserToAdminRequet";
import { UserService } from "../services/UserService";
import { RevokeUserFromAdminRequest } from "../models/user/RevokeUserFromAdminRequest";
import { EducatorService } from "../services/EducatorService";
import { AddStudentsToSubjectRequest } from "../models/user/AddStudentToSubjectRequest";
import { AddEducatorsRequest } from "../models/user/AddEducatorsRequest";
const router = express.Router();

router.use((req, res, next) => {
	next();
});

const studentService: StudentService = new StudentService();
const educatorService: EducatorService = new EducatorService();
const userService = new UserService();

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

router.post("/addStudentsToSubject", async (req, res) => {
	let body: AddStudentsToSubjectRequest = <AddStudentsToSubjectRequest>(
		req.body
	);
	studentService
		.AddUsersToSubject(body)
		.then(() => {
			res.status(200).send("ok");
		})
		.catch((err) => {
			res.status(400).json(err);
		});
});

// TODO Add educator to subject 

router.post("/addEducators", async (req, res) => {
	let body: AddEducatorsRequest = <AddEducatorsRequest>req.body;

	educatorService
		.AddEducators(body)
		.then(() => {
			res.status(200).send("ok");
		})
		.catch((err) => {
			res.status(400).json(err);
		});
});

export { router };
