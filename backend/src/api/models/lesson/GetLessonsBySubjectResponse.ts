
import { Lesson } from "../../database/Lesson";

export interface GetLessonsBySubjectResponse{ 
    statusMessage : string; 
    data:Lesson[]; 
}