interface validationResult {
    ok: boolean;
    message: string;
}

const missing = (param: string): validationResult => {
    return {ok: false, message: `Missing param: ${param}`};
}

export const validateCreateVirtualEntityRequest = (body: any): validationResult => {
    let keys = ["lesson_id", "title", "description"];
    let model_keys = ["name", "file_link", "file_size", "file_name", "file_type"];
    let quiz_keys = ["title", "description"];
    let question_keys = ["type", "question"];

    
    for (let key of keys) {
        let body_keys = Object.keys(body);
        if (!body_keys.includes(key))
            return missing(key);
    }
    if ('model' in body) {
        let body_keys = Object.keys(body.model);
        for (let key of model_keys) {
            if (!body_keys.includes(key))
                return missing(`model.${key}`);
        }
    }
    if('quiz' in body) {
        let body_keys = Object.keys(body.quiz);
        for (let key of quiz_keys) {
            if (!body_keys.includes(key))
                return missing(`quiz.${key}`);
        }
    }
    if (
        'quiz' in body && 
        'questions' in body.quiz && 
        body.quiz.questions instanceof Array && 
        body.quiz.questions.length > 0
    ) {
        for (let question of body.quiz.questions) {
            let body_keys = Object.keys(question);
            for (let key of question_keys) {
                if (!body_keys.includes(key))
                    return missing(`question.${key}`)
            }
        }
    }
    return {ok: true, message: ''}
}