import {Lesson} from '../model/lesson';
import * as model from '../model/apiModels';
import {ApiResponse} from '../../model/apiResponse';
import {client} from '../../index'

export async function createLesson(request: model.createLessonRequest) : Promise<ApiResponse | undefined> {
    
    if (!('title' in request) || !('description' in request)) {
        return undefined;
    } 
    let new_lesson: Lesson = {
        date: new Date(),
        description: request.description,
        title: request.title,
        subject_id: null
    }
    const query = `
        INSERT INTO lesson (description, title, date) VALUES ('${new_lesson.description}', '${new_lesson.title}', '${new_lesson.date.toISOString()}')
    `

    let response: ApiResponse = {
        message: 'Lesson created successfully'
    }

    return client.query(query)
    .then(res => {
        return {message: 'Lesson created successfully'}
    })
    .catch(err => {
        console.error(err);
        return {message: 'There was an error'}
    })
}