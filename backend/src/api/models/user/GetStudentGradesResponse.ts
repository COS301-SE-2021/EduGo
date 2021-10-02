import { Answer } from "../../../api/database/Answer";

export interface QuizGrade {
	name: string;
	quiz_total: number;
	student_score: number;
	quiz_answers: Answer[];
}

export interface GetStudentGradesResponse {
	subjects: SubjectGrades[];
}

export interface SubjectGrades {
	id: number;
	gradeAchieved: number;
	subjectName: string;
	lessonGrades: LessonGrades[];
}

export interface LessonGrades {
	id: number;
	gradeAchieved: number;
	lessonName: string;
	quizGrades: QuizGrade[];
}

// export interface studentAnswer {
// 	question_id: number;
// 	answer: String;
// }
