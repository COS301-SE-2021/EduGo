import express from "express";
import { uploadFile } from "../../fileUpload";
import { GetLessonsBySubjectRequest } from "../../lesson/models/GetLessonsBySubjectRequest";
import { GetSubjectsByEducator } from "../../subject/service/subjectService";
import { CreateSubjectRequest } from "../model/CreateSubjectRequest";
import { GetSubjectsByEducatorRequest } from "../model/GetSubjectsByEducatorRequest";
import { createSubject } from "../service/subjectService";

const router = express.Router();

router.use((req, res, next) => {
	next();
});

router.post("/createSubject", uploadFile.single("file"), async (req, res) => {
	const file: Express.MulterS3.File = <Express.MulterS3.File>req.file;

	let filelLink;

	// if image was submitted check make file link the link from Amazon S3 bucket. If not make it an empty string
	file ? (filelLink = file.location) : (filelLink = "");

	//Create subject
	createSubject(<CreateSubjectRequest>req.body, filelLink).then(
		(subjectResponse) => {
			res.status(200);
			res.json(subjectResponse);
		}
	);
});

router.post("/getSubjectsByEducator", async (req, res) => {
	//Create lesson
	GetSubjectsByEducator(<GetSubjectsByEducatorRequest>req.body).then(
		(subjects) => {
			res.status(200);
			res.json(subjects);
		}
	);
});

export { router };
