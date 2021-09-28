import { IsArray, IsEnum, IsInt, IsOptional, IsString } from "class-validator";
import { QuestionType } from "../../../api/database/Question";

export class Question {
	@IsEnum(QuestionType)
	type: string;

	imageLink?: string;

	@IsString()
	question: string;

	@IsArray()
	options: string[];

	@IsString()
	correctAnswer: string;
}

export class Quiz {
	@IsArray()
	questions: Question[];
}

export class Model {
	@IsString()
	fileLink: string;

	@IsOptional()
	@IsString()
	thumbnail?: string;
}
