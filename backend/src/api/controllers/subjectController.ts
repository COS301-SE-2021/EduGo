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

const router = express.Router();

const service: SubjectService = new SubjectService();
//TODO add upload image for a subject 
router.post(
	"/createSubject",
	passport.authenticate("jwt", { session: false }),
	isEducator,
	(req: RequestObjectWithUserId, res: any) => {
		//Create subject
		service
			.CreateSubject(<CreateSubjectRequest>req.body, req.user_id)
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
