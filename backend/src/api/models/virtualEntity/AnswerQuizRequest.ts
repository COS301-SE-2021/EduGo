export interface AnswerQuizRequest{
    quiz_id: number; 
    answers: Answer[]
}

export interface Answer {
    question_id:number,
    answer: String
}