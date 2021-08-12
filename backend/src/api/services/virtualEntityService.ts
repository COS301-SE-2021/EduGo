import { VirtualEntity } from "../database/VirtualEntity";
import { Repository } from "typeorm";
import { CreateVirtualEntityRequest } from "../models/virtualEntity/CreateVirtualEntityRequest";
import { Model } from "../database/Model";
import { Quiz } from "../database/Quiz";
import { CreateVirtualEntityResponse } from "../models/virtualEntity/CreateVirtualEntityResponse";
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
import { AnswerQuizRequest } from "../models/virtualEntity/AnswerQuizRequest";
import { getUserDetails } from "../helper/auth/Userhelper";
import { User } from "../database/User";
import { Grade } from "../database/Grade";
import { Answer } from "../database/Answer";
import { Student } from "../database/Student";
import { handleSavetoDBErrors } from "../helper/ErrorCatch";
import { Service } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import { TogglePublicRequest } from "../models/virtualEntity/TogglePublicRequest";
import {
	BadRequestError,
	InternalServerError,
	NotFoundError,
} from "routing-controllers";
import { TogglePublicResponse } from "../models/virtualEntity/TogglePublicResponse";

@Service()
export class VirtualEntityService {
	@InjectRepository(VirtualEntity)
	private virtualEntityRepository: Repository<VirtualEntity>;
	@InjectRepository(Quiz) private quizRepository: Repository<Quiz>;
	@InjectRepository(Question)
	private questionRepository: Repository<Question>;
	@InjectRepository(User) private userRepository: Repository<User>;
	@InjectRepository(Student) private studentRepository: Repository<Student>;

	/**
	 * @description This function will add a 3d model to a virtual entity. It will include checks to see if the virtual entity already has a model attached
	 * @param {AddModelToVirtualEntityFileData} request
	 * @returns {Promise<AddModelToVirtualEntityDatabaseResult>}
	 * @throws {NotFoundError, InternalServerError}
	 */
	async AddModelToVirtualEntity(
		request: AddModelToVirtualEntityFileData
	): Promise<AddModelToVirtualEntityDatabaseResult> {
		let entity: VirtualEntity | undefined;
		try {
			entity = await this.virtualEntityRepository.findOne(request.id, {
				relations: ["model", "quiz", "quiz.questions"],
			});
		} catch (err) {
			throw new NotFoundError("Could not find virtual entity");
		}

		if (!entity) throw new NotFoundError("Could not find virtual entity");
		if (entity.model)
			throw new BadRequestError("Virtual Entity already has a Model");

		let model: Model = new Model();
		model.name = request.name;
		model.description = request.description;
		model.file_name = request.file_name;
		model.file_link = request.file_link;
		model.file_size = request.file_size;
		model.file_type = request.file_type;

		entity.model = model;
		let result: VirtualEntity;

		try {
			result = await this.virtualEntityRepository.save(entity);
		} catch (err) {
			throw new InternalServerError("Could not save virtual entity");
		}

		if (result.model) {
			let response: AddModelToVirtualEntityDatabaseResult = {
				model_id: result.model.id,
			};
			return response;
		} else
			throw new InternalServerError(
				"Could not save the model to the virtual entity"
			);
	}

	async GetVirtualEntity(
		request: GetVirtualEntityRequest
	): Promise<GetVirtualEntityResponse> {
		let entity: VirtualEntity | undefined;
		try {
			entity = await this.virtualEntityRepository.findOne(request.id, {
				relations: ["model", "quiz", "quiz.questions"],
			});
		} catch (err) {
			throw new NotFoundError("Could not find virtual entity");
		}

		if (!entity) throw new NotFoundError("Could not find virtual entity");

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
	}

	/**
	 * @description Get all the virtual entities in the system
	 * @returns {Promise<GetVirtualEntitiesResponse>}
	 * @throws {NotFoundError, InternalServerError}
	 */
	async GetVirtualEntities(): Promise<GetVirtualEntitiesResponse> {
		let entities: VirtualEntity[];

		try {
			entities = await this.virtualEntityRepository.find({
				relations: ["model"],
			});
		} catch (err) {
			throw new InternalServerError("Could not find virtual entities");
		}

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
	}

	/**
	 * @description Create a new virtual entity from the CreateVirtualEntityRequest object which may contain a model, quiz, and questions
	 * @param {CreateVirtualEntityRequest} request
	 * @returns {Promise<CreateVirtualEntityResponse>}
	 * @throws {InternalServerError}
	 */
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

		let result: VirtualEntity;
		console.log("hereee");

		try {
			result = await this.virtualEntityRepository.save(ve);
		} catch (err) {
			throw new InternalServerError("Could not save virtual entity");
		}

		let response: CreateVirtualEntityResponse = {
			id: result.id,
			message: "Successfully added virtual entity",
		};
		return response;
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
	async AnswerQuiz(
		request: AnswerQuizRequest,
		user_id: number
	): Promise<String> {



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

		if (!user.student) throw new NotFoundError("Could not find student");
		if (!quiz) throw new NotFoundError("Could not find quiz");

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
				throw new BadRequestError("Question not found");
			}

			if (question) {
				let answer = new Answer();
				answer.answer = value.answer;
				answer.question = question;
				StudentGrade.answers.push(answer);
				if (value.answer == question.correctAnswer) score++;
			} else {
				throw new NotFoundError("Question not found");
			}
		}

		StudentGrade.score = score;
		StudentGrade.total = total;
		let student;
		try {
			student = await this.studentRepository.findOne(user.student.id, {
				relations: ["grades"],
			});

			if (!student) throw new NotFoundError("Student info not found");
			student.grades.push(StudentGrade);

			await this.studentRepository.save(student);
		} catch (error) {
			//TODO: handle error
			handleSavetoDBErrors(error);
			throw new InternalServerError("");
		}

		try {
			await this.userRepository.save(user);
		} catch (error) {
			throw new InternalServerError("There was an error");
		}
		return "ok";
	}

	/**
	 * @description This function will toggle the public flag of a virtual entity
	 * @param {TogglePublicRequest} request
	 * @param {number} user_id
	 * @returns {Promise<TogglePublicResponse>}
	 * @throws {BadRequestError}
	 */
	async TogglePublic(
		request: TogglePublicRequest,
		user_id: number
	): Promise<TogglePublicResponse> {
		try {
			let user = await this.userRepository.findOne(user_id, {
				relations: ["virtualEntities", "organisation"],
			});
			let ve = await this.virtualEntityRepository.findOne(request.id, {
				relations: ["organisation"],
			});
			if (!user) throw new BadRequestError("User not found");
			if (!ve)
				throw new BadRequestError(
					"Virtual entity does not belong to organisation"
				);

			if (ve.organisation.id === user.organisation.id) {
				ve.public = !ve.public;
				await this.virtualEntityRepository.save(ve);
				return { public: ve.public };
			} else
				throw new BadRequestError(
					"User does not belong to organisation"
				);
		} catch (err) {
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
			let source_entities = await this.virtualEntityRepository.find({
				public: true,
			});
			return source_entities.map((value) => {
				let entity: GVEs_VirtualEntity = {
					id: value.id,
					title: value.title,
					description: value.description,
				};
				if (value.model) {
					let model: GVEs_Model = {
						...value.model,
					};
					entity.model = model;
				}
				return entity;
			});
		} catch (err) {
			throw new InternalServerError(
				"Something went wrong when finding the public entities"
			);
		}
	}

	/**
	 * @description This function will get all the private virtual entities of the organisation
	 * @param {number} user_id
	 * @returns {Promise<GVEs_VirtualEntity[]>}
	 */
	async GetPrivateVirtualEntities(
		user_id: number
	): Promise<GVEs_VirtualEntity[]> {
		try {
			let user = await this.userRepository.findOne(user_id, {
				relations: ["virtualEntities", "organisation"],
			});
			if (!user) throw new BadRequestError("User not found");

			//A better query would be to get the organisation and then get all the virtual entities of that organisation
			return await this.virtualEntityRepository.find({
				organisation: user.organisation,
				public: false,
			});
		} catch (err) {
			throw new BadRequestError("User not found");
		}
	}
}
