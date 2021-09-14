export interface GetGradesByEducatorResponse{
	subjects: SubjectGrade[]; 
 }

 export interface SubjectGrade{
	 subjectName: string; 
	 students: StudentG[];
 }


export interface StudentG{
    username: string ; 
    firstname: string; 
    lastname: string; 
    studentgrade: number; 
}