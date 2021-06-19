export interface GVE_Model {
    id: number;
    name: string;
    description: string;
    file_link: string;
    file_size: number;
    file_type: string;
    file_name: string;
    preview_img?: string;
}

export interface GVE_Question {
    id: number;
    type: string;
    question: string;
    correctAnswer?: string;
    options?: string[];
}

export interface GVE_Quiz {
    id: number;
    title: string;
    description: string;
    questions: GVE_Question[];
}

export interface GetVirtualEntityResponse {
    id: number;
    title: string;
    description: string;
    quiz?: GVE_Quiz;
    model?: GVE_Model; 
}