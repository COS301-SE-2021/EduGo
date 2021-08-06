import { SubjectService } from "../services/SubjectService";
import { CreateSubjectRequest } from "../models/subject/CreateSubjectRequest";
import { GetSubjectsByUserRequest } from "../models/subject/GetSubjectsByUserRequest";
import {
	isEducator,
	isUser,
} from "../middleware/validate";
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
	BadRequestError
} from "routing-controllers";
import { User } from "../database/User";

// const router = express.Router();
// const service: SubjectService = Container.get(SubjectService);

@Service()
@Controller('/subject')
@UseBefore(passport.authenticate('jwt', { session: false }))
export class SubjectController {
	@Inject()
	private service: SubjectService;

	@Post('/createSubject')
	@UseBefore(isEducator)
	CreateSubject(
		@UploadedFile('file', {required: true, options: uploadFile}) file: Express.MulterS3.File, 
		@Body({required: true}) body: CreateSubjectRequest,
		@CurrentUser({required: true}) user?: User
	) {
		let link = file ? file.location : "https://edugo-files.s3.af-south-1.amazonaws.com/subject_default.jpg"
		if (file)
			if (user) return this.service.CreateSubject(body, user.id, link)
			else throw new BadRequestError('User is invalid');
		else throw new InternalServerError('File is invalid');
	}

	@Post('/getSubjectsByUser')
	@UseBefore(isUser)
	GetSubjectsByUser(@CurrentUser({required: true}) user: User) {
		return this.service.GetSubjectsByUser({user_id: user.id});
	}
}

// router.post(
// 	"/createSubject",
// 	passport.authenticate("jwt", { session: false }),
// 	isEducator,
// 	uploadFile.single("file"),
// 	(req: RequestObjectWithUserId, res: any) => {
// 		let imageLink = "";
// 		const file: Express.MulterS3.File = <Express.MulterS3.File>req.file;
// 		console.log(req);
// 		if (file == undefined)
// 			imageLink =
// 				"https://edugo-files.s3.af-south-1.amazonaws.com/subject_default.jpg";

// 		//Create subject
// 		service
// 			.CreateSubject(
// 				<CreateSubjectRequest>req.body,
// 				req.user_id,
// 				imageLink
// 			)
// 			.then((subjectResponse) => {
// 				res.status(200).json(subjectResponse);
// 			})
// 			.catch((err) => {
// 				handleErrors(err, res);
// 			});
// 	}
// );

// router.post(
// 	"/getSubjectsByUser",
// 	passport.authenticate("jwt", { session: false }),
// 	isUser,
// 	async (req: RequestObjectWithUserId, res: any) => {
// 		service
// 			.GetSubjectsByUser(<GetSubjectsByUserRequest>{
// 				user_id: req.user_id,
// 			})
// 			.then((subjects) => {
// 				res.status(200).json(subjects);
// 			})
// 			.catch((err) => {
// 				handleErrors(err, res);
// 			});
// 	}
// );

// export { router };
