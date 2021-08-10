import { IsInt, Min} from 'class-validator'

export class CreateLessonRequest {
	title: string;
	description: string;

	@IsInt()
	@Min(1)
	subjectId: number;
}
