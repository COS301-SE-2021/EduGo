import { VirtualEntity } from '../../database/entity/VirtualEntity';
import { createConnection } from 'typeorm';
import {ApiResponse} from '../../models/apiResponse';
import { CreateVirtualEntityRequest } from '../model/CreateVirtualEntityRequest';
import { VirtualEntityService } from './virtualEntityService';
import { Model } from '../../database/entity/Model';
import { Quiz } from '../../database/entity/quiz/Quiz';
import { CreateVirtualEntityResponse } from '../model/CreateVirtualEntityResponse';
import { GetVirtualEntitiesRequest } from '../model/GetVirtualEntitiesRequest';
import { GetVirtualEntitiesResponse } from '../model/GetVirtualEntitiesResponse';
import { Question, QuestionType } from '../../database/entity/quiz/Question';

export class VirtualEntityServiceImplementation extends VirtualEntityService {
    async GetVirtualEntities(request: GetVirtualEntitiesRequest): Promise<GetVirtualEntitiesResponse> {
        throw new Error('Method not implemented.');
    }

    async CreateVirtualEntity(request: CreateVirtualEntityRequest): Promise<CreateVirtualEntityResponse> {
        return createConnection().then(conn => {
            let virtualEntityRepo = conn.getRepository(VirtualEntity);
            
            let model: Model = new Model();
            if (request.model !== undefined) {
                model.name = request.model.name;
                model.description = request.model.description;
                model.file_link = request.model.file_link;
                model.file_name = request.model.file_name;
                model.file_size = request.model.file_size;
                model.file_type = request.model.file_type;
                model.preview_img = request.model.preview_img;
            }

            let quiz: Quiz = new Quiz();
            if (request.quiz !== undefined) {
                quiz.title = request.quiz.title;
                quiz.description = request.quiz.description;
                quiz.questions = request.quiz.questions.map(value => {
                    let question: Question = new Question();
                    question.question = value.question;
                    question.type = <QuestionType>value.type;
                    question.options = value.options;
                    question.correctAnswer = value.correctAnswer;
                    return question;
                })
            }
            let virtualEntity: VirtualEntity = new VirtualEntity();
            virtualEntity.title = request.title;
            virtualEntity.description = request.description;
            virtualEntity.model = model;
            virtualEntity.quiz = quiz;
            
            return virtualEntityRepo.save(virtualEntity).then(result => {
                let response: CreateVirtualEntityResponse = {
                    message: 'Successful',
                    id: result.id
                }
                return response;
            })
        })
    }

}