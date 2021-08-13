export class AnswerQuizRequest {
	quiz_id: number;
	lesson_id: number;
	answers: Answer[];
}

export class Answer {
	question_id: number;
	answer: String;
}
