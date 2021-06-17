import { ApiResponse } from "../../models/apiResponse";
import { Lesson } from "../../database/entity/Lesson";

export interface GetLessonsBySubjectResponse{ 
    statusMessage : string; 
    data:Lesson[]; 
}