import { IsInt, Min, Max } from 'class-validator';

export class CreateSubjectRequest {
	title: string;

	@IsInt()
	@Min(0)
	@Max(12)
	grade: number;
}
