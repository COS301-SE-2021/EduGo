import express from "express";
import { LessonService } from "../services/LessonService";
import { CreateLessonRequest } from "../models/lesson/CreateLessonRequest";
import { GetLessonsBySubjectRequest } from "../models/lesson/GetLessonsBySubjectRequest";
import passport from "passport";
import {ValidatationMiddleware}  from "../middleware/validate";
import { AddVirtualEntityToLessonRequest } from "../models/lesson/AddVirtualEntityToLessonRequest";
import { Inject, Service } from "typedi";
import { JsonController, Post, Body, UseBefore } from "routing-controllers";

//const router = express.Router();
//const service = Container.get(LessonService);

@Service()
@JsonController('/lesson')
@UseBefore(passport.authenticate('jwt', { session: false }))
export class LessonController {
	constructor(
		@Inject() private service: LessonService,
		@Inject() private validatinMiddleware: ValidatationMiddleware
	) {}
	


	@Post('/createLesson')
	@UseBefore(this?.validatinMiddleware.isEducator)
	CreateLesson(@Body({required: true}) body: CreateLessonRequest) {
		return this.service.CreateLesson(body);
	}

	@Post('/getLessonsBySubject')
	GetLessonsBySubject(@Body({required: true}) body: GetLessonsBySubjectRequest) {
		return this.service.GetLessonsBySubject(body);
	}

	@Post('/addVirtualEntityToLesson')
	@UseBefore(isEducator)
	async AddVirtualEntityToLesson(@Body({required: true}) body: AddVirtualEntityToLessonRequest) {
		return this.service.AddVirtualEntityToLesson(body);
	}
}


// //TODO add validate for all services 
// router.post(
// 	"/createLesson",
// 	passport.authenticate("jwt", { session: false }),
// 	isEducator,
// 	async (req:RequestObjectWithUserId, res:any) => {
// 		//Create lesson
// 		service
// 			.createLesson(<CreateLessonRequest>req.body)
// 			.then((response) => {
// 				res.status(200);
// 				res.json(response);
// 			})
// 			.catch((error) => {
// 				handleErrors(error, res);
// 			});
// 	}
// );

// router.post(
// 	"/getLessonsBySubject",
// 	passport.authenticate("jwt", { session: false }),
// 	async (req, res) => {
// 		//Create lesson
// 		service
// 			.GetLessonsBySubject(<GetLessonsBySubjectRequest>req.body)
// 			.then((response) => {
// 				res.status(200);
// 				res.json(response);
// 			});
// 	}
// );

// router.post(
// 	"/addVirtualEntityToLesson",
// 	passport.authenticate("jwt", { session: false }),
// 	isEducator,
// 	async (req: express.Request, res: express.Response) => {
// 		//Add virtual entity to lesson
// 		service
// 			.AddVirtualEntityToLesson(<AddVirtualEntityToLessonRequest>req.body)
// 			.then((response) => {
// 				res.status(200).send('ok');
// 			}).catch((error) => {
// 				handleErrors(error, res);
// 			});
// 	}
// );

// export { router };
