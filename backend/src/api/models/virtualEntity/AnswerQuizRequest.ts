export class AnswerQuizRequest{
    quiz_id: number; 
    answers: Answer[]
}

export class Answer {
    question_id: number;
    answer: String
}