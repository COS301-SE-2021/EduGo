import { IsArray, IsInt, IsOptional, IsString } from "class-validator";

export class Question {
    @IsString()
    type: string;

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