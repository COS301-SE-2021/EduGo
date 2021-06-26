interface validationResult {
    ok: boolean;
    message: string;
}

const missing = (param: string): validationResult => {
    return {ok: false, message: `Missing param: ${param}`};
}

const invalid = (param: string): validationResult => {
    return {ok: false, message: `Invalid param: ${param}`}
}

export const validateCreateVirtualEntityRequest = (body: any): validationResult => {
    let keys = ["lesson_id", "title", "description"];
    let model_keys = ["name", "file_link", "file_size", "file_name", "file_type"];
    let quiz_keys = ["title", "description"];
    let question_keys = ["type", "question"];

    
    let body_keys = Object.keys(body);
    for (let key of keys) {
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

    if (typeof body.lesson_id !== 'number' || body.lesson_id <= 0)
        return invalid('lesson_id')
    return {ok: true, message: ''}
}

export const validateAddModelToVirtualEntityRequest = (body: any): validationResult => {
    let keys = ["virtualEntity_id", "name", "description"];

    let body_keys = Object.keys(keys);
    for (let key in keys) {
        if (!body_keys.includes(key))
            return missing(key)
    }

    if (typeof body.virtualEntity_id !== 'number' || body.virtualEntity_id <= 0)
        return invalid('virtualEntity_id')

    return {ok: true, message: ''}
}

export const validateGetVirtualEntityRequest = (body: any): validationResult => {
    let keys = ["id"];

    let body_keys = Object.keys(body);
    for (let key in keys)
        if (!body_keys.includes(key))
            return missing(key);

    if (typeof body.id !== 'number' || body.id <= 0)
        return invalid('id')

    return {ok: true, message: ''}
}