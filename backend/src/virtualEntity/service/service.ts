import * as model from '../model/apiModels';
import {ApiResponse} from '../../model/apiResponse';
import {client} from '../../index'

export async function createVirtualEntity(request: model.createVirtualEntityRequest) : Promise<ApiResponse | undefined> {
    if (!('title' in request) || !('description' in request)) {
        return undefined;
    } 
    const query = `
    INSERT INTO virtualentity (description, title) VALUES ('${request.description}', '${request.title}')
    `
    return client.query(query)
    .then(res => {
        return {message: 'Virtual entity created successfully'}
    })
    .catch(err => {
        console.error(err);
        return {message: 'There was an error'}
    })
}