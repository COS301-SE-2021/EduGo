import {Quiz, Model} from './Default';

export interface CreateVirtualEntityRequest {
    title: string;
    description: string;
    quiz: Quiz;
    model?: Model;
    public?: boolean;
}