import { IsInt } from "class-validator";

export class DeleteSubjectRequest {
	@IsInt()
	subject_id: number;
}
