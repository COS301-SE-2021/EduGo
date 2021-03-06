//import { RegisterRequest } from "../models/registerRequest";
import { StudentService } from "../services/StudentService";
import { SetUserToAdminRequest } from "../models/user/SetUserToAdminRequet";
import { UserService } from "../services/UserService";
import { RevokeUserFromAdminRequest } from "../models/user/RevokeUserFromAdminRequest";
import { EducatorService } from "../services/EducatorService";
import { AddStudentsToSubjectRequest } from "../models/user/AddStudentToSubjectRequest";
import { AddEducatorsRequest } from "../models/user/AddEducatorsRequest";
import passport from "passport";
import {
	IsAdminMiddleware,
	IsEducatorMiddleware,
	IsUserMiddleware,
} from "../middleware/ValidationMiddleware";
import { AddEducatorToExistingSubjectRequest } from "../models/user/AddEducatorToExistingSubjectRequest";
import { Inject, Service } from "typedi";
import {
	Body,
	CurrentUser,
	Get,
	JsonController,
	Post,
	UseBefore,
} from "routing-controllers";
import { User } from "../database/User";

//TODO add endpoint to upload profile picture

@Service()
@JsonController("/user")
@UseBefore(passport.authenticate("jwt", { session: false }))
export class UserController {
	@Inject()
	private userService: UserService;

	@Inject()
	private studentService: StudentService;

	@Inject()
	private educatorService: EducatorService;

	@Post("/setUserToAdmin")
	@UseBefore(IsAdminMiddleware)
	SetUserToAdmin(@Body({ required: true }) body: SetUserToAdminRequest) {
		return this.userService.SetUserToAdmin(body);
	}

	@Post("/revokeUserFromAdmin")
	@UseBefore(IsAdminMiddleware)
	RevokeUserFromAdmin(
		@Body({ required: true }) body: RevokeUserFromAdminRequest
	) {
		return this.userService.RevokeUserFromAdmin(body);
	}

	@Post("/addStudentsToSubject")
	@UseBefore(IsEducatorMiddleware)
	AddStudentsToSubject(
		@Body({ required: true }) body: AddStudentsToSubjectRequest
	) {
		return this.studentService.AddUsersToSubject(body);
	}

	@Get("/getUserDetails")
	@UseBefore(IsUserMiddleware)
	GetUserDetails(@CurrentUser({ required: true }) id: number) {
		return this.userService.getUserDetails(id);
	}

	@Get("/getStudentGrades")
	@UseBefore(IsUserMiddleware)
	GetStudentGrades(@CurrentUser({ required: true }) id: number) {
		return this.studentService.GetStudentGrades(id);
	}

	@Get("/getGradesByEducator")
	@UseBefore(IsEducatorMiddleware)
	GradesByEducator(@CurrentUser({ required: true }) id: number) {
		return this.educatorService.getStudentGrades(id);
	}

	// TODO Test endpoint
	@Post("/addEducatorToExistingSubject")
	@UseBefore(IsEducatorMiddleware)
	AddEducatorToExistingSubject(
		@Body({ required: true }) body: AddEducatorToExistingSubjectRequest,
		@CurrentUser({ required: true }) id: number
	) {
		return this.educatorService.AddEducatorToExistingSubject(body, id);
	}
	@Post("/addEducators")
	@UseBefore(IsAdminMiddleware)
	AddEducators(
		@Body({ required: true }) body: AddEducatorsRequest,
		@CurrentUser({ required: true }) id: number
	) {
		return this.educatorService.AddEducators(body, id);
	}
}
