export interface GetStudentGradesResponse {
	grades: QuizGrade[];
}

export interface QuizGrade {
	quiz_id: number;
	quiz_total: number;
	student_score: number;
	answers: studentAnswer[];
}

export interface studentAnswer {
	question_id: number;
	answer: String;
}
