import { IsInt } from "class-validator";

export class DeleteSubjectRequest {
	@IsInt()
	id: number;
}
