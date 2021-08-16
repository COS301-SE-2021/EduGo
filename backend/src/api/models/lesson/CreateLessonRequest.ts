import { IsInt, IsString, Min} from 'class-validator'

export class CreateLessonRequest {
	@IsString()
	title: string;
	description: string;
	subjectId: number;
}
