import { ApiResponse } from "../../../models/apiResponse";
import { Lesson } from "../../Database/Lesson";

export interface GetLessonsBySubjectResponse{ 
    statusMessage : string; 
    data:Lesson[]; 
}