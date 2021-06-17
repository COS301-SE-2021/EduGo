import { CreateLessonRequest } from '../models/CreateLessonRequest';
import {  GetLessonResponse} from '../models/GetLessonResponse'
import { ApiResponse } from '../../models/apiResponse';
import { Lesson } from '../../database/entity/Lesson';
import { createConnection } from 'typeorm';


export async function createLesson(request: CreateLessonRequest) : Promise<ApiResponse> {
    let response: ApiResponse = {
        message: '',
        type: 'fail'
    }
  
    if(request.title== null||request.date == null|| request.description == null){
        response.message = "Missing parameters"
        response.type = 'fail'
        return response; 
    }

    else{
        let conn = await createConnection();
        let lessonRepository = conn.getRepository(Lesson);
        let lesson: Lesson = new Lesson();
    
        lesson.title = request.title;
        lesson.description = request.description;
        lesson.date = request.date; 
        return lessonRepository.save(lesson).then(value => {
            response.message = `Successfully added lesson ${value.id}`
            response.type = 'success'
            return response; 

        }).catch(() => {
            response.message = 'There was an error adding the lesson to the database'
            response.type = 'fail'
            return response;
        })

    }
}


export async function getLesson() : Promise<GetLessonResponse> {
    
    
} 