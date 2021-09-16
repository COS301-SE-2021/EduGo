import { Quiz } from "./Default";

export interface GetQuizesByLessonResponse {
	data: Quiz[];
	answeredQuiz_ids: number[];
}
