export interface Question {
    type: string;
    question: string;
    options?: string[];
    correctAnswer?: string;
}

export interface Quiz {
    title: string;
    description: string;
    questions: Question[];
}

export interface Model {
    name: string;
    description: string;
    file_link: string;
    file_size: number;
    file_name: string;
    file_type: string;
    preview_img?: string;
}