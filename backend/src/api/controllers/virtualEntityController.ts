import { CreateVirtualEntityRequest } from "../models/virtualEntity/CreateVirtualEntityRequest";
import { GetVirtualEntityRequest } from "../models/virtualEntity/GetVirtualEntityRequest";
import { VirtualEntityService } from "../services/VirtualEntityService";
import { uploadFile } from "../helper/aws/fileUpload";
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
	UploadModel(
		@UploadedFile("file", { required: true, options: uploadFile })
		file: Express.MulterS3.File
	) {
		if (file) {
			let response: any = {
				file_name: file.key,
				file_size: file.size,
				file_type: file.key.split(".")[file.key.split(".").length - 1],
				file_link: file.location,
			};
			return response;
		} else throw new BadRequestError("User is invalid");
	}

	@Post("/addToVirtualEntity")
	@UseBefore(IsEducatorMiddleware)
	async AddToVirtualEntity(
		@UploadedFile("file", { required: true, options: uploadFile })
		file: Express.MulterS3.File,
		@Body({ required: true }) body: AddModelToVirtualEntityRequest
	) {
		if (file) {
			let baseFile = {
				file_name: file.key,
				file_link: file.location,
				file_type: file.key.split(".")[file.key.split(".").length - 1],
				file_size: file.size,
			};

			let data: AddModelToVirtualEntityFileData = {
				id: body.virtualEntity_id,
				description: body.description,
				name: body.name,
				...baseFile,
			};
			let response = await this.service.AddModelToVirtualEntity(data);
			if (response) {
				let resp: AddModelToVirtualEntityResponse = {
					model_id: response.model_id,
					...body,
					...baseFile,
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
