import { IsEmail, IsNotEmpty, IsString } from "class-validator";

export class VerifyInvitationRequest {
	@IsNotEmpty()
	@IsEmail()
	email: string;

	@IsNotEmpty()
	@IsString()
	verificationCode: string;
}
