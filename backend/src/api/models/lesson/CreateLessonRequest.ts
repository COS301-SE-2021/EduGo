import { IsInt, Min} from 'class-validator'

export class CreateLessonRequest {
	title: string;
	description: string;
	startTime: string;
	endTime: string;

	@IsInt()
	@Min(1)
	subjectId: number;
}
