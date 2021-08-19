import { IsInt, Min } from 'class-validator';
export class GetLessonsBySubjectRequest {
    @IsInt()
    @Min(1)
    subjectId: number;
}