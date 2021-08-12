import { IsEmail, IsNotEmpty, IsString } from "class-validator";

export enum userType {
	student = "student",
	educator = "educator",
	firstAdmin = "firstTimeAdmin",
}

export class RegisterRequest {
	@IsNotEmpty()
	@IsString()
	password: string;

	@IsNotEmpty()
	@IsString()
	user_firstName: string;

	@IsNotEmpty()
	@IsString()
	user_lastName: string;

	@IsNotEmpty()
	@IsEmail()
	user_email: string;

	userType: userType;

	@IsNotEmpty()
	@IsString()
	username: string;
	organisation_id: number;
}
