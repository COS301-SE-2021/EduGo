import { CreateVirtualEntityRequest } from "../models/virtualEntity/CreateVirtualEntityRequest";
import { GetVirtualEntityRequest } from "../models/virtualEntity/GetVirtualEntityRequest";
import { VirtualEntityService } from "../services/VirtualEntityService";

import { uploadFile } from "../helper/aws/fileUpload";
import {
	AddModelToVirtualEntityFileData,
	AddModelToVirtualEntityRequest,
} from "../models/virtualEntity/AddModelToVirtualEntityRequest";
import { AddModelToVirtualEntityResponse } from "../models/virtualEntity/AddModelToVirtualEntityResponse";
import { isEducator, isUser } from "../middleware/validate";
import { AnswerQuizRequest } from "../models/virtualEntity/AnswerQuizRequest";
import { Inject } from "typedi";
import {
	BadRequestError,
	Body,
	CurrentUser,
	Get,
	InternalServerError,
	Post,
	UploadedFile,
	UseBefore,
} from "routing-controllers";
import { User } from "../database/User";
import { GetVirtualEntitiesRequest } from "../models/virtualEntity/GetVirtualEntitiesRequest";
import { TogglePublicRequest } from "../models/virtualEntity/TogglePublicRequest";

export class VirtualEntityController {
	@Inject()
	private service: VirtualEntityService;

	@Post("/createVirtualEntity")
	@UseBefore(isUser)
	CreateVirtualEntity(@Body({ required: true }) body: CreateVirtualEntityRequest) {
		return this.service.CreateVirtualEntity(body);
	}

	@Post("/uploadModel")
	@UseBefore(isEducator)
	UploadModel(@UploadedFile("file", { required: true, options: uploadFile }) file: Express.MulterS3.File) {
		if (file) {
			let response: any = {
				file_name: file.key,
				file_size: file.size,
				file_type: file.key.split(".")[file.key.split(".").length - 1],
				file_link: file.location,
			};
			return response;
		} 
		else throw new BadRequestError("User is invalid");
	}

	@Post("/addToVirtualEntity")
	@UseBefore(isEducator)
	async AddToVirtualEntity(
		@UploadedFile("file", { required: true, options: uploadFile }) file: Express.MulterS3.File,
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

	@Get("/getVirtualEntities")
	@UseBefore(isUser)
	GetVirtualEntities() {
		return this.service.GetVirtualEntities();
	}

	@Post("/getVirtualEntity")
	@UseBefore(isUser)
	GetVirtualEntity(@Body({ required: true }) body: GetVirtualEntityRequest) {
		return this.service.GetVirtualEntity(body);
	}

	@Post("/answerQuiz")
	@UseBefore(isUser)
	AnswerQuiz(
		@Body({ required: true }) body: AnswerQuizRequest,
		@CurrentUser({ required: true }) user: User
	) {
		return this.service.AnswerQuiz(body, user.id);
	}

	@Post("/togglePublic")
	@UseBefore(isEducator)
	TogglePublic(@Body({ required: true }) body: TogglePublicRequest, @CurrentUser({ required: true }) user: User) {
		return this.service.TogglePublic(body, user.id);
	}

	@Post("/getPublicVirtualEntities")
	@UseBefore(isEducator)
	GetPublicVirtualEntities() {
		return this.service.GetPublicVirtualEntities();
	}

	@Post("/getPrivateVirtualEntities")
	@UseBefore(isEducator)
	GetPrivateVirtualEntities(@CurrentUser({ required: true }) user: User) {
		return this.service.GetPrivateVirtualEntities(user.id);
	}

}

//TODO add endpoint to make snapshot of 3d model

// TODO get virtual entities by lesson
