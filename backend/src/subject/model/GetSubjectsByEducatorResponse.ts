import { String } from "aws-sdk/clients/acm";
import { Subject } from "./subject";

export interface GetLessonsBySubjectResponse{ 
    statusMessage : String; 
    data:Subject[]; 
}