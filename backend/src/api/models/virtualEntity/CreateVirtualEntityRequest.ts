import {Quiz, Model} from './Default';

export class CreateVirtualEntityRequest {
    title: string;
    description: string;
    quiz: Quiz;
    model?: Model;
    public?: boolean;
}