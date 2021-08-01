import express from "express";
import { LessonService } from "../services/lessonService";
import { CreateLessonRequest } from "../models/lesson/CreateLessonRequest";
import { GetLessonsBySubjectRequest } from "../models/lesson/GetLessonsBySubjectRequest";
import { handleErrors } from "../helper/ErrorCatch";
import passport from "passport";
import { isEducator, RequestObjectWithUserId } from "../middleware/validate";

const router = express.Router();
const service = new LessonService();
router.use((req, res, next) => {
	next();
});

router.post(
	"/createLesson",
	passport.authenticate("jwt", { session: false }),
	isEducator,
	async (req:RequestObjectWithUserId, res:any) => {
		//Create lesson
		service
			.createLesson(<CreateLessonRequest>req.body)
			.then((response) => {
				res.status(200);
				res.json(response);
			})
			.catch((error) => {
				handleErrors(error, res);
			});
	}
);

router.post(
	"/getLessonsBySubject",
	passport.authenticate("jwt", { session: false }),
	async (req, res) => {
		//Create lesson
		service
			.GetLessonsBySubject(<GetLessonsBySubjectRequest>req.body)
			.then((response) => {
				res.status(200);
				res.json(response);
			});
	}
);

export { router };
