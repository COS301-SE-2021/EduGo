import { CreateLessonRequest } from './lesson/models/CreateLessonRequest';
import { ApiResponse } from './models/apiResponse';
import { Lesson } from './database/entity/Lesson';
import { createConnection } from 'typeorm';

class database{
    async createLesson(request: CreateLessonRequest) : Promise<ApiResponse> {
        let response: ApiResponse = {
            message: '',
            type: 'fail'
        }
        let conn = await createConnection();
        let lessonRepository = conn.getRepository(Lesson);
    
        let lesson: Lesson = new Lesson();
        lesson.title = request.title;
        lesson.description = request.description;
    
        return lessonRepository.save(lesson).then(value => {
            response.message = `Successfully added lesson ${value.id}`
            response.type = 'success'
            return response;
        }).catch(() => {
            response.message = 'There was an error adding the lesson'
            response.type = 'fail'
            return response;
        })
    }
}

export default database