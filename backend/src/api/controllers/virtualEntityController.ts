/* eslint-disable @typescript-eslint/explicit-module-boundary-types */
import { CreateVirtualEntityRequest } from "../models/virtualEntity/CreateVirtualEntityRequest";
import { GetVirtualEntityRequest } from "../models/virtualEntity/GetVirtualEntityRequest";
import { VirtualEntityService } from "../services/VirtualEntityService";
import { upload, FileManagement } from "../helper/File";
import {
	AddModelToVirtualEntityFileData,
	AddModelToVirtualEntityRequest,
} from "../models/virtualEntity/AddModelToVirtualEntityRequest";
import { AddModelToVirtualEntityResponse } from "../models/virtualEntity/AddModelToVirtualEntityResponse";
import {
	IsEducatorMiddleware,
	IsUserMiddleware,
} from "../middleware/ValidationMiddleware";
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
import { ExternalRequests } from "../helper/ExternalRequests";
@Service()
@JsonController("/virtualEntity")
@UseBefore(passport.authenticate("jwt", { session: false }))
export class VirtualEntityController {
	constructor(
		@Inject() private service: VirtualEntityService,
		@Inject() private fileManagement: FileManagement,
		@Inject() private externalRequests: ExternalRequests
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
			const result = await this.fileManagement.UploadModelToAzure(file);
			const thumbnail = await this.externalRequests.GenerateThumbnail(
				result
			);
			const gltf = await this.externalRequests.ConvertModel(result);
			const response: any = {
				fileLink: result,
				thumbnail: thumbnail.uploaded,
				gltf,
			};
			return response;
		} else throw new BadRequestError("User is invalid");
	}

	@Post("/uploadImage")
	@UseBefore(IsEducatorMiddleware)
	async UploadImage(
		@UploadedFile("image", { required: true, options: upload })
		file: Express.Multer.File
	) {
		if (file) {
			const result = await this.fileManagement.UploadImageToAzure(file);
			const response: any = {
				fileLink: result,
			};
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
			const result = await this.fileManagement.UploadModelToAzure(file);
			const baseFile = {
				fileLink: result,
			};

			const data: AddModelToVirtualEntityFileData = {
				id: body.virtualEntity_id,
				...baseFile,
			};
			const response = await this.service.AddModelToVirtualEntity(data);
			if (response) {
				const resp: AddModelToVirtualEntityResponse = {
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

	@Post("/getVirtualEntities")
	@UseBefore(IsEducatorMiddleware)
	async GetVirtualEntities(@CurrentUser({ required: true }) id: number) {
		const publicVirtualEntities =
			await this.service.GetPublicVirtualEntities();
		const privateVirtualEntities =
			await this.service.GetPrivateVirtualEntities(id);

		return [...publicVirtualEntities, ...privateVirtualEntities];
	}

	@Post("/getQuizesByLesson")
	@UseBefore(IsUserMiddleware)
	GetQuizesByLesson(
		@Body({ required: true }) body: GetQuizesByLessonRequest,
		@CurrentUser({ required: true }) id: number
	) {
		return this.service.GetQuizesByLesson(body, id);
	}
}

//TODO add endpoint to make snapshot of 3d model
