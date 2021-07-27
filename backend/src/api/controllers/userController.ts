import express from "express";

//import { RegisterRequest } from "../models/registerRequest";
import { StudentService } from "../services/StudentService";
import { SetUserToAdminRequest } from "../models/user/SetUserToAdminRequet";
import { UserService } from "../services/UserService";
import { RevokeUserFromAdminRequest } from "../models/user/RevokeUserFromAdminRequest";
import { EducatorService } from "../services/EducatorService";
import { AddStudentsToSubjectRequest } from "../models/user/AddStudentToSubjectRequest";
import { AddEducatorsRequest } from "../models/user/AddEducatorsRequest";
import passport from "passport";
import { isAdmin, isEducator, RequestObjectWithUserId } from "../middleware/validate";
const router = express.Router();

router.use((req, res, next) => {
	next();
});

const studentService: StudentService = new StudentService();
const educatorService: EducatorService = new EducatorService();
const userService = new UserService();

router.post("/setUserToAdmin",passport.authenticate("jwt", { session: false }), async (req, res) => {
	let body: SetUserToAdminRequest = <SetUserToAdminRequest>req.body;
	userService.setUserToAdmin(body).then(() => {
		res.status(200).send("ok");
	});
});

router.post("/revokeUserFromAdmin",passport.authenticate("jwt", { session: false }), async (req, res) => {
	let body: RevokeUserFromAdminRequest = <RevokeUserFromAdminRequest>req.body;
	userService.setUserToAdmin(body).then(() => {
		res.status(200).send("ok");
	});
});

router.post("/addStudentsToSubject",passport.authenticate("jwt", { session: false }),isEducator, async (req:RequestObjectWithUserId, res:any) => {
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

// TODO Add educator to subject admin responsibility 

router.post("/addEducators",passport.authenticate("jwt", { session: false }),isAdmin, async (req, res) => {
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
