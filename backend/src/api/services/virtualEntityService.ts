import { VirtualEntity } from "../database/VirtualEntity";
import {
	getConnection,
	getRepository,
	NoNeedToReleaseEntityManagerError,
} from "typeorm";
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
import { AnswerQuizRequest } from "../models/virtualEntity/AnswerQuizRequest";
import { getUserDetails } from "../helper/auth/Userhelper";
import { User } from "../database/User";
import { Error400 } from "../errors/Error";
import { Grade } from "../database/Grade";
import { Answer } from "../database/Answer";
import { Student } from "../database/Student";
import { handleSavetoDBErrors } from "../helper/ErrorCatch";
import { NonExistantItemError } from "../errors/NonExistantItemError";

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
		let conn = getConnection();
		let lessonRepo = conn.getRepository(Lesson);

		return lessonRepo
			.findOne(request.lesson_id, {
				relations: ["virtualEntities"],
			})
			.then((lesson) => {
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

					return lessonRepo
						.save(lesson)
						.then((result) => {
							let response: CreateVirtualEntityResponse = {
								id: ve.id,
								message:
									"Successfully added virtual entity and updated lesson",
							};
							return response;
						})
						.catch((err) => {
							console.log(err);
							throw err;
						});
				} else {
					throw new Error("Could not find lesson");
				}
			});
	}
	/**
	 * @description This function allows a student to answer a quiz
	 * 1. get the student object
	 * 2. create the grade object for the student
	 * 3. set the answers given for each question
	 * 4. grade the quiz by checking if correct answer is equivalent to the given answer
	 * @param {AnswerQuizRequest} request
	 * @param {number} user_id
	 * @memberof VirtualEntityService
	 */
	async answerQuiz(request: AnswerQuizRequest, user_id: number) {
		let user: User;
		let quiz: Quiz | undefined;
		try {
			user = await getUserDetails(user_id);
			quiz = await getRepository(Quiz).findOne(request.quiz_id, {
				relations: ["questions"],
			});
		} catch (error) {
			throw error;
		}
		//console.log(user);
		if (user.student != null) {
			if (quiz) {
				let StudentGrade = new Grade();
				let score: number = 0;
				let total: number = quiz.questions.length;
				StudentGrade.quiz = quiz;
				StudentGrade.answers = [];
				for (let value of request.answers) {
					let question: Question | undefined;
					try {
						question = await getRepository(Question).findOne(
							value.question_id
						);
					} catch (error) {
						throw new error();
					}
					if (question) {
						let answer = new Answer();
						answer.answer = value.answer;
						answer.question = question;
						StudentGrade.answers.push(answer);
						if (value.answer == question.correctAnswer) {
							score++;
						}
					} else {
						throw new Error400("Error 400 question not found");
					}
				}
				StudentGrade.score = score;
				StudentGrade.total = total;
				let studentRepo = getRepository(Student);
				let student;
				try {
					student = await studentRepo.findOne(user.student.id, {
						relations: ["grades"],
					});

					if (!student)
						throw new NonExistantItemError(
							"Student info not found"
						);

					student.grades.push(StudentGrade);

					await studentRepo.save(student).catch(err=>{
						throw handleSavetoDBErrors(err)
					});
				} catch (error) {
					throw error;
				}

				getRepository(User)
					.save(user)
					.then((res) => {
						return;
					})
					.catch((error) => {
						throw handleSavetoDBErrors(error);
					});
			} else throw new Error400("Quiz not found");
		} else throw new Error400("User is not an Student");
	}
}
