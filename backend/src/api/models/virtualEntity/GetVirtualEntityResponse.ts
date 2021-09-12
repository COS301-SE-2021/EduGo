import { Model, Quiz, Question } from "./Default";

export class GVE_Model extends Model {
	id: number;
}

export class GVE_Question extends Question {
	id: number;
}

export class GVE_Quiz extends Quiz {
	id: number;
}

export class GetVirtualEntityResponse {
	id: number;
	title: string;
	description: string;
	quiz?: GVE_Quiz;
	model?: GVE_Model;
	information?: string[];
}
