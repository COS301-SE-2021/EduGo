interface Question {
    type: string;
    question: string;
    options?: string[];
    correctAnswer?: string; 
}

interface Quiz {
    title: string;
    description: string;
    questions: Question[];
}

interface Model {
    name: string;
    description: string;
    file_link: string;
    file_size: number;
    file_name: string;
    file_type: string;
    preview_img?: string;
}

export interface CreateVirtualEntityRequest {
    lesson_id: number;
    title: string;
    description: string;
    quiz?: Quiz;
    model?: Model;
}