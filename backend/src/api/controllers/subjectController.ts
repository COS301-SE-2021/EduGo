import { SubjectService } from "../services/SubjectService";
import { CreateSubjectRequest } from "../models/subject/CreateSubjectRequest";
import { IsEducatorMiddleware, IsUserMiddleware } from "../middleware/ValidationMiddleware";
import passport from "passport";
import { upload, FileManagement } from "../helper/File";
import { Service, Inject } from "typedi";
import {
	UseBefore,
	Post,
	UploadedFile,
	Body,
	CurrentUser,
	InternalServerError,
	JsonController,
	ContentType,
} from "routing-controllers";
import { DeleteSubjectRequest } from "../models/subject/DeleteSubjectRequest";

@Service()
@JsonController("/subject")
@UseBefore(passport.authenticate("jwt", { session: false }))
export class SubjectController {
	constructor(
		@Inject() private service: SubjectService,
		@Inject() private fileManagement: FileManagement
	) {}

	@Post("/createSubject")
	@UseBefore(IsEducatorMiddleware)
	async CreateSubject(
		@UploadedFile("file", { required: true, options: upload })
		file: Express.Multer.File,
		@Body({ required: true }) body: CreateSubjectRequest,
		@CurrentUser({ required: true }) id: number
	) {
		if (file) {
			let result = await this.fileManagement.UploadImageToAzure(file);
			let link = file
				? result
				: "https://edugo-files.s3.af-south-1.amazonaws.com/subject_default.jpg";
			return this.service.CreateSubject(body, id, link);
		}
		else throw new InternalServerError("File is invalid");
	}

	@Post('/deleteSubject')
	@UseBefore(IsEducatorMiddleware)
	async DeleteSubject(@Body({ required: true }) body: DeleteSubjectRequest) {
		return this.service.DeleteSubject(body);
	}

	@Post("/getSubjectsByUser")
	@ContentType("application/json")
	@UseBefore(IsUserMiddleware)
	GetSubjectsByUser(@CurrentUser({ required: true }) id: number) {
		return this.service.GetSubjectsByUser(id);
	}
}
