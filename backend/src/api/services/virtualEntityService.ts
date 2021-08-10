import { VirtualEntity } from "../database/VirtualEntity";
import {
	Repository,
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
import { DatabaseError } from "../errors/DatabaseError";
import { Service } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import { TogglePublicRequest } from "../models/virtualEntity/TogglePublicRequest";
import { BadRequestError, InternalServerError } from "routing-controllers";
import { TogglePublicResponse } from "../models/virtualEntity/TogglePublicResponse";


@Service()
export class VirtualEntityService {
	GetSubjectsByUser(arg0: { user_id: any; }) {
		throw new Error("Method not implemented.");
	}

	@InjectRepository(VirtualEntity) private virtualEntityRepository: Repository<VirtualEntity>;
	@InjectRepository(Quiz) private quizRepository: Repository<Quiz>;
	@InjectRepository(Question) private questionRepository: Repository<Question>;
	@InjectRepository(User) private userRepository: Repository<User>;

	@InjectRepository(Student) private studentRepository: Repository<Student>;

	async AddModelToVirtualEntity(
		request: AddModelToVirtualEntityFileData
	): Promise<AddModelToVirtualEntityDatabaseResult> {

		return this.virtualEntityRepository
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
					return this.virtualEntityRepository.save(entity).then((result) => {
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

		return this.virtualEntityRepository
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

		return this.virtualEntityRepository
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
		
		let ve: VirtualEntity = new VirtualEntity();
		ve.title = request.title;
		ve.description = request.description;
		ve.public = request.public ?? false;

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

		return this.virtualEntityRepository.save(ve).then((result) => {
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
			quiz = await this.quizRepository.findOne(request.quiz_id, {
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
						question = await this.questionRepository.findOne(
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
				let student;
				try {
					student = await this.studentRepository.findOne(user.student.id, {
						relations: ["grades"],
					});

					if (!student)
						throw new NonExistantItemError(
							"Student info not found"
						);

					student.grades.push(StudentGrade);

					await this.studentRepository.save(student).catch((err) => {
						throw handleSavetoDBErrors(err);
					});
				} catch (error) {
					throw error;
				}

				this.userRepository
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

	/**
	 * @description This function will toggle the public flag of a virtual entity
	 * @param {TogglePublicRequest} request
	 * @param {number} user_id
	 * @returns {Promise<TogglePublicResponse>}
	 * @throws {BadRequestError}
	 */
	async TogglePublic(request: TogglePublicRequest, user_id: number): Promise<TogglePublicResponse> {
		try {
			let user = await this.userRepository.findOne(user_id, {relations: ["virtualEntities", "organisation"]});
			if (user) {
				let ve = await this.virtualEntityRepository.findOne(request.id, {relations: ["organisation"]});
				if (ve) {
					if (ve.organisation.id === user.organisation.id) {
						ve.public = !ve.public;
						await this.virtualEntityRepository.save(ve)
						return {public: ve.public};
					} else throw new BadRequestError("Virtual entity does not belong to organisation");
				}
				else throw new BadRequestError("Virtual entity not found");
			}
			else throw new BadRequestError("User not found");
		}
		catch (err) {
			throw new BadRequestError("User not found");
		}
	}

	/**
	 * @description This function will get all the public virtual entities
	 * @returns {GVEs_VirtualEntity[]}
	 * @throws {InternalServerError}
	 */
	async GetPublicVirtualEntities(): Promise<GVEs_VirtualEntity[]> {
		try {
			let source_entities = await this.virtualEntityRepository.find({public: true});
			let entities: GVEs_VirtualEntity[] = source_entities.map((value) => {
				let entity: GVEs_VirtualEntity = {
					id: value.id,
					title: value.title,
					description: value.description,
				}
				if (value.model) {
					let model: GVEs_Model = {
						...value.model
					}
					entity.model = model;
				}
				return entity;
			});
			return entities
		}
		catch (err) {
			throw new InternalServerError('Something went wrong when finding the public entities')
		}
	}

	/**
	 * @description This function will get all the private virtual entities of the organisation
	 * @param {number} user_id
	 * @returns {Promise<GVEs_VirtualEntity[]>}
	 */
	async GetPrivateVirtualEntities(user_id: number): Promise<GVEs_VirtualEntity[]> {
		try {
			let user = await this.userRepository.findOne(user_id, {relations: ["virtualEntities", "organisation"]});
			if (user) {
				//A better query would be to get the organisation and then get all the virtual entities of that organisation
				let entities: GVEs_VirtualEntity[] = await this.virtualEntityRepository.find({
					organisation: user.organisation,
					public: false,
				});
				return entities;
			}
			else throw new BadRequestError("User not found");
		}
		catch (err) {
			throw new BadRequestError("User not found");
		}
	}
}
