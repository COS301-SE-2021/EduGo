import { CreateVirtualEntityRequest } from "../models/virtualEntity/CreateVirtualEntityRequest";
import { GetVirtualEntityRequest } from "../models/virtualEntity/GetVirtualEntityRequest";
import { VirtualEntityService } from "../services/VirtualEntityService";
import { upload, UploadModelToAzure } from "../helper/File";
import {
	AddModelToVirtualEntityFileData,
	AddModelToVirtualEntityRequest,
} from "../models/virtualEntity/AddModelToVirtualEntityRequest";
import { AddModelToVirtualEntityResponse } from "../models/virtualEntity/AddModelToVirtualEntityResponse";
import { IsEducatorMiddleware, IsUserMiddleware } from "../middleware/ValidationMiddleware";
import { AnswerQuizRequest } from "../models/virtualEntity/AnswerQuizRequest";
import { Inject, Service } from "typedi";
import {
	BadRequestError,
	Body,
	CurrentUser,
	InternalServerError,
	JsonController,
	Post,
	UploadedFile,
	UseBefore,
} from "routing-controllers";
import { TogglePublicRequest } from "../models/virtualEntity/TogglePublicRequest";
import passport from "passport";
import { GetQuizesByLessonRequest } from "../models/virtualEntity/GetQuizesByLessonRequest";
import { GenerateThumbnail } from "../helper/ExternalRequests";
@Service()
@JsonController("/virtualEntity")
@UseBefore(passport.authenticate("jwt", { session: false }))
export class VirtualEntityController {
	constructor(
		@Inject() private service: VirtualEntityService
	) {}

	@Post("/createVirtualEntity")
	@UseBefore(IsUserMiddleware)
	CreateVirtualEntity(
		@Body({ required: true }) body: CreateVirtualEntityRequest,
		@CurrentUser() id: number
	) {
		return this.service.CreateVirtualEntity(body, id);
	}

	@Post("/uploadModel")
	@UseBefore(IsEducatorMiddleware)
	async UploadModel(
		@UploadedFile("file", { required: true, options: upload })
		file: Express.Multer.File
	) {
		if (file) {
			let result = await UploadModelToAzure(file)
			let thumbnail = await GenerateThumbnail(result);
			let response: any = { fileLink: result, thumbnail: thumbnail.uploaded };
			return response;
		} else throw new BadRequestError("User is invalid");
	}

	@Post("/addToVirtualEntity")
	@UseBefore(IsEducatorMiddleware)
	async AddToVirtualEntity(
		@UploadedFile("file", { required: true, options: upload })
		file: Express.Multer.File,
		@Body({ required: true }) body: AddModelToVirtualEntityRequest
	) {
		if (file) {
			let result = await UploadModelToAzure(file);
			let baseFile = {
				fileLink: result,
			};

			let data: AddModelToVirtualEntityFileData = {
				id: body.virtualEntity_id,
				...baseFile,
			};
			let response = await this.service.AddModelToVirtualEntity(data);
			if (response) {
				let resp: AddModelToVirtualEntityResponse = {
					model_id: response.model_id,
					...body,
					...baseFile,
					thumbnail: response.thumbnail,
				};
				return resp;
			}
			throw new InternalServerError("Unable to save to Database");
		} else throw new BadRequestError("User is invalid");
	}

	@Post("/getVirtualEntity")
	@UseBefore(IsUserMiddleware)
	GetVirtualEntity(@Body({ required: true }) body: GetVirtualEntityRequest) {
		return this.service.GetVirtualEntity(body);
	}

	@Post("/answerQuiz")
	@UseBefore(IsUserMiddleware)
	AnswerQuiz(
		@Body({ required: true }) body: AnswerQuizRequest,
		@CurrentUser({ required: true }) id: number
	) {
		return this.service.AnswerQuiz(body, id);
	}

	@Post("/togglePublic")
	@UseBefore(IsEducatorMiddleware)
	TogglePublic(
		@Body({ required: true }) body: TogglePublicRequest,
		@CurrentUser({ required: true }) id: number
	) {
		return this.service.TogglePublic(body, id);
	}

	@Post("/getPublicVirtualEntities")
	@UseBefore(IsEducatorMiddleware)
	GetPublicVirtualEntities() {
		return this.service.GetPublicVirtualEntities();
	}

	@Post("/getPrivateVirtualEntities")
	@UseBefore(IsEducatorMiddleware)
	GetPrivateVirtualEntities(@CurrentUser({ required: true }) id: number) {
		return this.service.GetPrivateVirtualEntities(id);
	}

	@Post("/getQuizesByLesson")
	@UseBefore(IsUserMiddleware)
	GetQuizesByLesson(@Body({ required: true }) body: GetQuizesByLessonRequest) {
		return this.service.GetQuizesByLesson(body);
	}
}

//TODO add endpoint to make snapshot of 3d model
