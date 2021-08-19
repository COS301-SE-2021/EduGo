import { IsInt, Min, Max } from 'class-validator';

export class CreateSubjectRequest {
	title: string;

	grade: number;
}
