import * as model from '../model/apiModels';
import {ApiResponse} from '../../model/apiResponse';
import {client} from '../../index'

export async function createQuestion(request: model.createQuestionRequest) : Promise<ApiResponse | undefined> {
    if (!('question' in request) || !('correctAnswer' in request)) {
        return undefined;
    } 
    const query = `
    INSERT INTO question (question, correctAnswer) VALUES ('${request.question}', '${request.correctAnswer}')
    `
    return client.query(query)
    .then(res => {
        return {message: 'Question created successfully'}
    })
    .catch(err => {
        console.error(err);
        return {message: 'There was an error'}
    })
}