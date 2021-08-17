import { IsInt, IsString, Min} from 'class-validator'

export class CreateLessonRequest {
	@IsString()
	title: string;

	@IsString()
	description: string;

	@IsInt()
	@Min(1)
	subjectId: number;
}
