import { IsInt, Min } from 'class-validator';

export class AddVirtualEntityToLessonRequest {
    @IsInt()
    @Min(1)
    virtualEntityId: number;

    @IsInt()
    @Min(1)
    lessonId: number;
}