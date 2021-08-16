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
    @IsString()
    title: string;

    @IsString()
    description: string;

    @IsArray()
    questions: Question[];
}

export class Model {
    @IsString()
    name: string;

    @IsString()
    description: string;

    @IsString()
    file_link: string;

    @IsInt()
    file_size: number;

    @IsString()
    file_name: string;

    @IsString()
    file_type: string;

    @IsOptional()
    @IsString()
    preview_img?: string;
}