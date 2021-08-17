import { IsInt, Min } from "class-validator";

export class GetQuizesByLessonRequest {
    @IsInt()
    @Min(1)
    id: number;
}