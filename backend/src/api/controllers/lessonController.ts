import express from "express";
import { LessonService } from "../services/LessonService";
import { CreateLessonRequest } from "../models/lesson/CreateLessonRequest";
import { GetLessonsBySubjectRequest } from "../models/lesson/GetLessonsBySubjectRequest";
import passport from "passport";
import {
	IsEducatorMiddleware,
	IsUserMiddleware,
} from "../middleware/ValidationMiddleware";
import { AddVirtualEntityToLessonRequest } from "../models/lesson/AddVirtualEntityToLessonRequest";
import { Inject, Service } from "typedi";
import { JsonController, Post, Body, UseBefore } from "routing-controllers";

//const router = express.Router();
//const service = Container.get(LessonService);

@Service()
@JsonController("/lesson")
@UseBefore(passport.authenticate("jwt", { session: false }))
export class LessonController {
	constructor(@Inject() private service: LessonService) {}

	@Post("/createLesson")
	@UseBefore(IsEducatorMiddleware)
	CreateLesson(@Body({ required: true }) body: CreateLessonRequest) {
		return this.service.CreateLesson(body);
	}

	@Post("/getLessonsBySubject")
	@UseBefore(IsUserMiddleware)
	GetLessonsBySubject(
		@Body({ required: true }) body: GetLessonsBySubjectRequest
	) {
		return this.service.GetLessonsBySubject(body);
	}

	@Post("/addVirtualEntityToLesson")
	@UseBefore(IsEducatorMiddleware)
	async AddVirtualEntityToLesson(
		@Body({ required: true }) body: AddVirtualEntityToLessonRequest
	) {
		return this.service.AddVirtualEntityToLesson(body);
	}
}
