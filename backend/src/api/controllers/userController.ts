//import { RegisterRequest } from "../models/registerRequest";
import { StudentService } from "../services/StudentService";
import { SetUserToAdminRequest } from "../models/user/SetUserToAdminRequet";
import { UserService } from "../services/UserService";
import { RevokeUserFromAdminRequest } from "../models/user/RevokeUserFromAdminRequest";
import { EducatorService } from "../services/EducatorService";
import { AddStudentsToSubjectRequest } from "../models/user/AddStudentToSubjectRequest";
import { AddEducatorsRequest } from "../models/user/AddEducatorsRequest";
import passport from "passport";
import { isAdmin, isEducator, isUser } from "../middleware/validate";
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
	@UseBefore(isAdmin)
	SetUserToAdmin(@Body({ required: true }) body: SetUserToAdminRequest) {
		return this.userService.setUserToAdmin(body);
	}

	@Post("/revokeUserFromAdmin")
	@UseBefore(isAdmin)
	RevokeUserFromAdmin(
		@Body({ required: true }) body: RevokeUserFromAdminRequest
	) {
		return this.userService.revokeUserFromAdmin(body);
	}

	@Post("/addStudentsToSubject")
	@UseBefore(isEducator)
	AddStudentsToSubject(
		@Body({ required: true }) body: AddStudentsToSubjectRequest
	) {
		return this.studentService.AddUsersToSubject(body);
	}

	@Get("/getUserDetails")
	@UseBefore(isUser)
	GetUserDetails(@CurrentUser({ required: true }) user: User) {
		return this.userService.getUserDetails(user.id);
	}

	@Get("/getStudentGrades")
	@UseBefore(isUser)
	GetStudentGrades(@CurrentUser({ required: true }) user: User) {
		return this.studentService.getStudentGrades(user.id);
	}


	// TODO Test endpoint
	@Post("/addEducatorToExistingSubject")
	@UseBefore(isEducator)
	AddEducatorToExistingSubject(
		@Body({ required: true }) body: AddEducatorToExistingSubjectRequest,
		@CurrentUser({ required: true }) user: User
	) {
		return this.educatorService.addEducatorToExistingSubject(body, user.id);
	}
	@Post("/addEducators")
	@UseBefore(isAdmin)
	AddEducators(
		@Body({ required: true }) body: AddEducatorsRequest,
		@CurrentUser({ required: true }) user: User
	) {
		return this.educatorService.AddEducators(body, user.id);
	}
}
