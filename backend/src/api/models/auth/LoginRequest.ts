import { IsAlphanumeric, IsEmail, IsNotEmpty, IsString } from "class-validator";

export class LoginRequest {
	@IsNotEmpty()
	@IsString()
	username: string;

	@IsNotEmpty()
	@IsString()
	password: string;
}
