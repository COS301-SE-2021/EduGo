import { IsInt, Min} from 'class-validator'

export class CreateLessonRequest {
	title: string;
	description: string;
	subjectId: number;
}
