import { CreateLessonRequest } from '../models/CreateLessonRequest';
import {  GetLessonsBySubjectResponse} from '../models/GetLessonsBySubjectResponse'
import { ApiResponse } from '../../models/apiResponse';
import { Lesson } from '../../database/entity/Lesson';
import { Any, createConnection } from 'typeorm';
import { GetLessonsBySubjectRequest } from '../models/GetLessonsBySubjectRequest';

let statusRes: ApiResponse = {
    message: '',
    type: 'fail'
}

export async function createLesson(request: CreateLessonRequest) : Promise<ApiResponse> {
    
  
    if(request.title== null||request.date == null|| request.description == null|| request.subjectId){
        statusRes.message = "Missing parameters"
        statusRes.type = 'fail'
        return statusRes; 
    }

    else{
        let conn = await createConnection();
        let lessonRepository = conn.getRepository(Lesson);
        let lesson: Lesson = new Lesson();
    
        lesson.title = request.title;
        lesson.description = request.description;
        lesson.date = request.date; 
        return lessonRepository.save(lesson).then(value => {
            statusRes.message = `Successfully added lesson ${value.lessonId}`
            statusRes.type = 'success'
            return statusRes; 

        }).catch(() => {
            statusRes.message = 'There was an error adding the lesson to the database'
            statusRes.type = 'fail'
            return statusRes;
        })

    }
}


export async function GetLessonsBySubject(request: GetLessonsBySubjectRequest)  {

    if(request.subjectId==null)
    {
        statusRes.message = "SubjectId not provided"; 
        return statusRes; 
    }

    else{
            let conn = await createConnection();
            let lessonRepository = conn.getRepository(Lesson);
            //let lessons = <Lesson[]><unknown>lessonRepository.find({ subjectId: request.subjectId }).then(value => {
           // let LessonsData: GetLessonsBySubjectResponse= {data:lessons,statusMessage:"Successful"} 
            //return LessonsData; 
            //     return; 
        // }).catch(() => {
        //     statusRes.message = 'There was an error getting lessons for subjectId provided'
        //     statusRes.type = 'fail'
        //     return statusRes;
        // })
        
    }
    
} 