import express from "express";
import { SubjectService } from "../services/SubjectService";
import { CreateSubjectRequest } from "../models/subject/CreateSubjectRequest";
import { GetSubjectsByUserRequest } from "../models/subject/GetSubjectsByUserRequest";
import {
	isEducator,
	isUser,
	passportJWT,
	RequestObjectWithUserId,
} from "../middleware/validate";
import { handleErrors } from "../helper/ErrorCatch";
import passport from "passport";
import { uploadFile } from "../helper/aws/fileUpload";
import { Container } from "typedi";


const router = express.Router();

const service: SubjectService = Container.get(SubjectService);
router.post(
	"/createSubject",
	passport.authenticate("jwt", { session: false }),
	isEducator,
	uploadFile.single("file"),
	(req: RequestObjectWithUserId, res: any) => {
		let imageLink = "";
		const file: Express.MulterS3.File = <Express.MulterS3.File>req.file;
		console.log(req);
		if (file == undefined)
			imageLink =
				"https://edugo-files.s3.af-south-1.amazonaws.com/subject_default.jpg";

		//Create subject
		service
			.CreateSubject(
				<CreateSubjectRequest>req.body,
				req.user_id,
				imageLink
			)
			.then((subjectResponse) => {
				res.status(200).json(subjectResponse);
			})
			.catch((err) => {
				handleErrors(err, res);
			});
	}
);

router.post(
	"/getSubjectsByUser",
	passport.authenticate("jwt", { session: false }),
	isUser,
	async (req: RequestObjectWithUserId, res: any) => {
		service
			.GetSubjectsByUser(<GetSubjectsByUserRequest>{
				user_id: req.user_id,
			})
			.then((subjects) => {
				res.status(200).json(subjects);
			})
			.catch((err) => {
				handleErrors(err, res);
			});
	}
);

export { router };
