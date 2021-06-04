import {Subject} from '../model/subject';
import * as model from '../model/apiModels';
import {ApiResponse} from '../../model/apiResponse';
import {client} from '../../index'

export async function createSubject(request: model.createSubjectRequest) : Promise<ApiResponse | undefined> {
    
    if (!('title' in request)) {
        return undefined;
    } 
    const query = `
    INSERT INTO subject (description, title) VALUES ('${request.description}', '${request.title}')
    `
    return client.query(query)
    .then(res => {
        return {message: 'Subject created successfully'}
    })
    .catch(err => {
        console.error(err);
        return {message: 'There was an error'}
    })

}