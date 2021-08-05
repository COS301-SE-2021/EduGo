import { VirtualEntity } from "../database/VirtualEntity";
import { getConnection, getRepository } from "typeorm";
import { CreateVirtualEntityRequest } from "../models/virtualEntity/CreateVirtualEntityRequest";
import { Model } from "../database/Model";
import { Quiz } from "../database/Quiz";
import { CreateVirtualEntityResponse } from "../models/virtualEntity/CreateVirtualEntityResponse";
import { GetVirtualEntitiesRequest } from "../models/virtualEntity/GetVirtualEntitiesRequest";
import {
	GetVirtualEntitiesResponse,
	GVEs_Model,
	GVEs_VirtualEntity,
} from "../models/virtualEntity/GetVirtualEntitiesResponse";
import { Question, QuestionType } from "../database/Question";
import { GetVirtualEntityRequest } from "../models/virtualEntity/GetVirtualEntityRequest";
import {
	GetVirtualEntityResponse,
	GVE_Model,
	GVE_Quiz,
} from "../models/virtualEntity/GetVirtualEntityResponse";
import { AddModelToVirtualEntityFileData } from "../models/virtualEntity/AddModelToVirtualEntityRequest";
import { AddModelToVirtualEntityDatabaseResult } from "../models/virtualEntity/AddModelToVirtualEntityResponse";
import { Lesson } from "../database/Lesson";
import { DatabaseError } from "../errors/DatabaseError";

export class VirtualEntityService {
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
						throw new Error(
							"This virtual entity already has a model"
						);
					}
					entity.model = model;
					return virtualEntityRepo.save(entity).then((result) => {
						if (result.model) {
							let response: AddModelToVirtualEntityDatabaseResult =
								{
									model_id: result.model.id,
								};
							return response;
						} else {
							throw new Error(
								"There was an error adding to the DB"
							);
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
					throw new Error(
						`Could not find entity with id ${request.id}`
					);
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
		let virtualEntityRepo = getRepository(VirtualEntity);
		
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

		return virtualEntityRepo.save(ve).then((result) => {
			let response: CreateVirtualEntityResponse = {
				id: result.id,
				message: "Successfully added virtual entity"
			};
			return response;
		})
		.catch((err) => {
			throw new DatabaseError('Could not add virtual entity');
		});
	}
}
