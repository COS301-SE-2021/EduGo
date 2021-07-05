import express from "express";

//import { RegisterRequest } from "../models/registerRequest";
import { json } from "body-parser";
import { AddUsersToSubjectRequest } from "../models/AddUsersToSubjectRequest";
import { StudentService } from "../service/StudentServiceImplementation";
const router = express.Router();

router.use((req, res, next) => {
	next();
});

const service: StudentService = new StudentService();

router.post('/addUsersToSubject', async (req, res) => {
	let body: AddUsersToSubjectRequest = <AddUsersToSubjectRequest>req.body;
	service.AddUsersToSubject(body).then(() => {
		res.status(200).send('ok')
	})
	.catch(err => {
		res.status(400).json(err);
	})
})

export { router };
