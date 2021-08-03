import {Quiz, Model} from './Default';

export interface CreateVirtualEntityRequest {
    lesson_id: number;
    title: string;
    description: string;
    quiz?: Quiz;
    model?: Model;
}