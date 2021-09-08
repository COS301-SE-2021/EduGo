import { SubjectService } from "../services/SubjectService";
import { CreateSubjectRequest } from "../models/subject/CreateSubjectRequest";
import { IsEducatorMiddleware, IsUserMiddleware } from "../middleware/ValidationMiddleware";
import passport from "passport";
import { uploadFile } from "../helper/aws/fileUpload";
import { Service, Inject } from "typedi";
import {
	Controller,
	UseBefore,
	Post,
	UploadedFile,
	Body,
	CurrentUser,
	InternalServerError,
	JsonController,
	ContentType,
	Header,
	Authorized,
} from "routing-controllers";

@Service()
@JsonController("/subject")
@UseBefore(passport.authenticate("jwt", { session: false }))
export class SubjectController {
	@Inject()
	private service: SubjectService;

	@Post("/createSubject")
	@UseBefore(IsEducatorMiddleware)
	CreateSubject(
		@UploadedFile("file", { required: true, options: uploadFile })
		file: Express.MulterS3.File,
		@Body({ required: true }) body: CreateSubjectRequest,
		@CurrentUser({ required: true }) id: number
	) {
		let link = file
			? file.location
			: "https://edugo-files.s3.af-south-1.amazonaws.com/subject_default.jpg";
		if (file) return this.service.CreateSubject(body, id, link);
		else throw new InternalServerError("File is invalid");
	}

	@Post("/getSubjectsByUser")
	@ContentType("application/json")
	@UseBefore(IsUserMiddleware)
	GetSubjectsByUser(@CurrentUser({ required: true }) id: number) {
		return this.service.GetSubjectsByUser(id);
	}
}
