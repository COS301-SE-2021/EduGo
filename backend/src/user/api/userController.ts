import express from "express";

//import { RegisterRequest } from "../models/registerRequest";
import { json } from "body-parser";
import { AddStudentsToSubjectRequest } from "../models/AddStudentsToSubjectRequest";
import { StudentService } from "../service/StudentServiceImplementation";
import { EducatorService } from "../service/EducatorServiceImplementation";
import { AddEducatorsRequest } from "../models/AddEducatorsRequest";
const router = express.Router();

router.use((req, res, next) => {
	next();
});

const studentService: StudentService = new StudentService();
const educatorService: EducatorService = new EducatorService();

router.post('/addStudentsToSubject', async (req, res) => {
	let body: AddStudentsToSubjectRequest = <AddStudentsToSubjectRequest>req.body;
	studentService.AddUsersToSubject(body).then(() => {
		res.status(200).send('ok')
	})
	.catch(err => {
		res.status(400).json(err);
	})
})

router.post('/addEducators', async (req, res) => {
	let body: AddEducatorsRequest = <AddEducatorsRequest>req.body;

	educatorService.AddEducators(body).then(() => {
		res.status(200).send('ok')
	})
	.catch(err => {
		res.status(400).json(err)
	})
})

export { router };
