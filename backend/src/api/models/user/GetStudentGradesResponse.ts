export class QuizGrade {
	id:number;
	name: string;
	quiz_total: number;
	student_score: number;
}


export class GetStudentGradesResponse{
	subjects: SubjectGrades[]; 
 }

 export class SubjectGrades{
	 id:number; 
	 gradeAchieved: number; 
	 subjectName:string; 
	 lessonGrades: LessonGrades[]
 }

 export class LessonGrades{
	id?:number;
	gradeAchieved?: number;
	lessonName: string; 
	quizGrades: QuizGrade[]
}

// export interface studentAnswer {
// 	question_id: number;
// 	answer: String;
// }
