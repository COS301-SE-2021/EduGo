import { Model, Quiz, Question } from "./Default";

export interface GVE_Model extends Model {
    id: number;
}

export interface GVE_Question extends Question {
    id: number;
}

export interface GVE_Quiz extends Quiz {
    id: number;
}

export interface GetVirtualEntityResponse {
    id: number;
    title: string;
    description: string;
    quiz?: GVE_Quiz;
    model?: GVE_Model; 
}