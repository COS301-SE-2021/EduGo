import { VirtualEntity } from "../../database/entity/VirtualEntity";
import { createConnection, getConnection } from "typeorm";
import { CreateVirtualEntityRequest } from "../model/CreateVirtualEntityRequest";
import { VirtualEntityService } from "./virtualEntityService";
import { Model } from "../../database/entity/Model";
import { Quiz } from "../../database/entity/quiz/Quiz";
import { CreateVirtualEntityResponse } from "../model/CreateVirtualEntityResponse";
import { GetVirtualEntitiesRequest } from "../model/GetVirtualEntitiesRequest";
import {
  GetVirtualEntitiesResponse,
  GVEs_Model,
  GVEs_VirtualEntity,
} from "../model/GetVirtualEntitiesResponse";
import { Question, QuestionType } from "../../database/entity/quiz/Question";
import { GetVirtualEntityRequest } from "../model/GetVirtualEntityRequest";
import {
  GetVirtualEntityResponse,
  GVE_Model,
  GVE_Quiz,
} from "../model/GetVirtualEntityResponse";
import { AddModelToVirtualEntityFileData } from "../model/AddModelToVirtualEntityRequest";
import { AddModelToVirtualEntityDatabaseResult } from "../model/AddModelToVirtualEntityResponse";
import { Lesson } from "../../database/entity/Lesson";

export class VirtualEntityServiceImplementation extends VirtualEntityService {
  async AddModelToVirtualEntity(
    request: AddModelToVirtualEntityFileData
  ): Promise<AddModelToVirtualEntityDatabaseResult> {
    let conn = getConnection();
    let virtualEntityRepo = conn.getRepository(VirtualEntity);

    return virtualEntityRepo
      .findOne(request.id, {
        relations: ["model", "quiz", "quiz.questions"],
      })
      .then((entity) => {
        if (entity) {
          let model: Model = new Model();
          model.name = request.name;
          model.description = request.description;
          model.file_name = request.file_name;
          model.file_link = request.file_link;
          model.file_size = request.file_size;
          model.file_type = request.file_type;
          if (entity.model) {
            throw new Error("This virtual entity already has a model");
          }
          entity.model = model;
          return virtualEntityRepo.save(entity).then((result) => {
            if (result.model) {
              let response: AddModelToVirtualEntityDatabaseResult = {
                model_id: result.model.id,
              };
              return response;
            } else {
              throw new Error("There was an error adding to the DB");
            }
          });
        } else {
          throw new Error("There was an error");
        }
      });
  }

  async GetVirtualEntity(
    request: GetVirtualEntityRequest
  ): Promise<GetVirtualEntityResponse> {
    let conn = getConnection();
    let virtualEntityRepo = conn.getRepository(VirtualEntity);

    return virtualEntityRepo
      .findOne(request.id, {
        relations: ["model", "quiz", "quiz.questions"],
      })
      .then((entity) => {
        if (entity) {
          let response: GetVirtualEntityResponse = {
            id: entity.id,
            title: entity.title,
            description: entity.description,
          };
          if (entity.model) {
            let model: GVE_Model = { ...entity.model };
            response.model = model;
          }
          if (entity.quiz) {
            let quiz: GVE_Quiz = { ...entity.quiz };
            response.quiz = quiz;
          }
          return response;
        } else {
          throw new Error(`Could not find entity with id ${request.id}`);
        }
      });
  }

  async GetVirtualEntities(
    request: GetVirtualEntitiesRequest
  ): Promise<GetVirtualEntitiesResponse> {
    let conn = getConnection();
    let virtualEntityRepo = conn.getRepository(VirtualEntity);

    return virtualEntityRepo
      .find({
        relations: ["model"],
      })
      .then((entities) => {
        let response: GetVirtualEntitiesResponse = {
          entities: entities.map((value) => {
            let entity: GVEs_VirtualEntity = {
              title: value.title,
              description: value.description,
              id: value.id,
            };
            if (value.model) {
              let model: GVEs_Model = { ...value.model };
              entity.model = model;
            }
            return entity;
          }),
        };
        return response;
      });
  }

  async CreateVirtualEntity(
    request: CreateVirtualEntityRequest
  ): Promise<CreateVirtualEntityResponse> {
    let conn = getConnection();
    let lessonRepo = conn.getRepository(Lesson)

    return lessonRepo.findOne(request.lesson_id, {
      relations: ["virtualEntities"]
    }).then(lesson => {
      if (lesson) {
        let ve: VirtualEntity = new VirtualEntity();
        ve.title = request.title;
        ve.description = request.description;

        if (request.model !== undefined) {
          let model: Model = new Model();
          model.name = request.model.name;
          model.description = request.model.description;
          model.file_link = request.model.file_link;
          model.file_name = request.model.file_name;
          model.file_size = request.model.file_size;
          model.file_type = request.model.file_type;
          model.preview_img = request.model.preview_img;
          ve.model = model;
        }

        if (request.quiz !== undefined) {
          let quiz: Quiz = new Quiz();
          quiz.title = request.quiz.title;
          quiz.description = request.quiz.description;
          quiz.questions = request.quiz.questions.map((value) => {
            let question: Question = new Question();
            question.question = value.question;
            question.type = <QuestionType>value.type;
            question.options = value.options;
            question.correctAnswer = value.correctAnswer;
            return question;
          });
          ve.quiz = quiz;
        }
        lesson.virtualEntities.push(ve);

        return lessonRepo.save(lesson).then(result => {
          let response: CreateVirtualEntityResponse = {
            id: ve.id,
            message: "Successfully added virtual entity and updated lesson"
          }
          return response;
        })
        .catch(err => {console.log(err); throw err});
      }
      else {
        throw new Error('Could not find lesson')
      }
    })
  }
}
