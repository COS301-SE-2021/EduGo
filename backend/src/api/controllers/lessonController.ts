import express from "express";
import { LessonService } from "../services/LessonService";
import { CreateLessonRequest } from "../models/lesson/CreateLessonRequest";
import { GetLessonsBySubjectRequest } from "../models/lesson/GetLessonsBySubjectRequest";
import { handleErrors } from "../helper/ErrorCatch";
import passport from "passport";
import { isEducator, RequestObjectWithUserId } from "../middleware/validate";
import { AddVirtualEntityToLessonRequest } from "../models/lesson/AddVirtualEntityToLessonRequest";
import { Container } from "typedi";

const router = express.Router();
const service = Container.get(LessonService);
router.use((req, res, next) => {
	next();
});
//TODO add validate for all services 
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

router.post(
	"/addVirtualEntityToLesson",
	passport.authenticate("jwt", { session: false }),
	isEducator,
	async (req: express.Request, res: express.Response) => {
		//Add virtual entity to lesson
		service
			.AddVirtualEntityToLesson(<AddVirtualEntityToLessonRequest>req.body)
			.then((response) => {
				res.status(200).send('ok');
			}).catch((error) => {
				handleErrors(error, res);
			});
	}
);

export { router };
