export interface GetStudentGradesResponse {
	quiz_grades: any[];
}
export interface LessonGrades{
	mark: number; 

}
export interface QuizGrade {
	name: string;
	quiz_total: number;
	student_score: number;
	//answers: studentAnswer[];
}

// export interface studentAnswer {
// 	question_id: number;
// 	answer: String;
// }
