
import { validationResult } from "../../helper/ValidationHelper";
import { missing, invalid } from "../../../api/helper/ValidationHelper";

export const validateRegisterRequest = (body: any): validationResult => {
    let keys = ["lesson_id", "title", "description"];
    let model_keys = ["name", "file_link", "file_size", "file_name", "file_type"];
    let quiz_keys = ["title", "description"];
    let question_keys = ["type", "question"];

    
    let body_keys = Object.keys(body);
    for (let key of keys) {
        if (!body_keys.includes(key))
            return missing(key);
    }

    return {ok: true, message: ''}
}