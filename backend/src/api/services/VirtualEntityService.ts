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
import { Inject, Service } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import { TogglePublicRequest } from "../models/virtualEntity/TogglePublicRequest";
import {
	BadRequestError,
	InternalServerError,
	NotFoundError,
} from "routing-controllers";
import { TogglePublicResponse } from "../models/virtualEntity/TogglePublicResponse";
import { Lesson } from "../database/Lesson";
import { GetQuizesByLessonRequest } from "../models/virtualEntity/GetQuizesByLessonRequest";
import { GetQuizesByLessonResponse } from "../models/virtualEntity/GetQuizesByLessonResponse";
import { ExternalRequests } from "../helper/ExternalRequests";

@Service()
export class VirtualEntityService {
	constructor(
		@InjectRepository(VirtualEntity)
		private virtualEntityRepository: Repository<VirtualEntity>,
		@InjectRepository(Quiz) private quizRepository: Repository<Quiz>,
		@InjectRepository(Question)
		private questionRepository: Repository<Question>,
		@InjectRepository(User) private userRepository: Repository<User>,
		@InjectRepository(Student)
		private studentRepository: Repository<Student>,
		@InjectRepository(Lesson) private lessonRepository: Repository<Lesson>,
		@Inject() private externalRequests: ExternalRequests
	) {}

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
				relations: ["model"],
			});
		} catch (err) {
			throw new NotFoundError("Could not find virtual entity");
		}

		if (!entity) throw new NotFoundError("Could not find virtual entity");
		if (entity.model)
			throw new BadRequestError("Virtual Entity already has a Model");

		const thumbnail = await this.externalRequests.GenerateThumbnail(
			request.fileLink
		);
		await this.externalRequests.ConvertModel(request.fileLink);

		const model: Model = new Model();
		model.fileLink = request.fileLink;
		model.thumbnail = thumbnail.uploaded;

		entity.model = model;
		let result: VirtualEntity;

		try {
			result = await this.virtualEntityRepository.save(entity);
		} catch (err) {
			throw new InternalServerError("Could not save virtual entity");
		}

		if (result.model) {
			const response: AddModelToVirtualEntityDatabaseResult = {
				model_id: result.model.id,
				thumbnail: thumbnail.uploaded,
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
		console.log(entity);

		const response: GetVirtualEntityResponse = {
			id: entity.id,
			title: entity.title,
			description: entity.description,
		};

		if (entity.model) {
			const model: GVE_Model = { ...entity.model };
			response.model = model;
		}
		if (entity.quiz) {
			const quiz: GVE_Quiz = { ...entity.quiz };
			response.quiz = quiz;
		}
		return response;
	}

	/**
	 * @description Create a new virtual entity from the CreateVirtualEntityRequest object which may contain a model, quiz, and questions
	 * @param {CreateVirtualEntityRequest} request
	 * @returns {Promise<CreateVirtualEntityResponse>}
	 * @throws {InternalServerError}
	 */
	async CreateVirtualEntity(
		request: CreateVirtualEntityRequest,
		user_id: number
	): Promise<CreateVirtualEntityResponse> {
		let user: User | undefined;
		try {
			user = await this.userRepository.findOne(user_id, {
				relations: ["organisation"],
			});
		} catch (err) {
			throw new NotFoundError("Could not find user");
		}

		if (!user) throw new NotFoundError("Could not find user");

		const ve: VirtualEntity = new VirtualEntity();
		ve.title = request.title;
		ve.description = request.description?.map((info) => info) || [];
		ve.public = request.public ?? false;
		ve.organisation = user.organisation;

		if (request.model !== undefined) {
			const model: Model = new Model();
			model.fileLink = request.model.fileLink;
			model.thumbnail = request.model.thumbnail;
			ve.model = model;
		}

		if (request.quiz !== undefined) {
			const quiz: Quiz = new Quiz();
			quiz.questions = request.quiz.questions.map((value) => {
				const question: Question = new Question();
				question.question = value.question;
				question.type = <QuestionType>value.type;

				if (
					<QuestionType>value.type == QuestionType.image &&
					value.imageLink == undefined
				) {
					throw new BadRequestError(
						"Image link for Image question not provided"
					);
				} else {
					question.imageLink = value.imageLink;
				}

				question.options = value.options;
				question.correctAnswer = value.correctAnswer;
				return question;
			});
			ve.quiz = quiz;
		}

		let result: VirtualEntity;

		try {
			result = await this.virtualEntityRepository.save(ve);
		} catch (err) {
			throw new InternalServerError("Could not save virtual entity");
		}

		if (!result) throw new NotFoundError("Virtual entity not saved ");
		const response: CreateVirtualEntityResponse = {
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
	): Promise<string> {
		let user: User | undefined;
		let quiz: Quiz | undefined;
		let lesson: Lesson | undefined;
		try {
			user = await this.userRepository.findOne(user_id, {
				relations: ["organisation", "educator", "student"],
			});
			quiz = await this.quizRepository.findOne(request.quiz_id, {
				relations: ["questions"],
			});
			lesson = await this.lessonRepository.findOne(request.lesson_id, {
				relations: ["subject"],
			});
		} catch (error) {
			throw error;
		}

		if (!user) throw new NotFoundError("Could not find user");
		if (!user.student) throw new NotFoundError("Could not find student");
		if (!quiz) throw new NotFoundError("Could not find quiz");
		if (!lesson) throw new NotFoundError("Could not find lesson");

		const StudentGrade = new Grade();
		let score = 0;
		const total: number = quiz.questions.length;
		StudentGrade.quiz = quiz;
		StudentGrade.answers = [];
		StudentGrade.lesson = lesson;
		StudentGrade.subject = lesson.subject;
		for (const value of request.answers) {
			let question: Question | undefined;

			try {
				question = await this.questionRepository.findOne(
					value.question_id
				);
			} catch (error) {
				throw new BadRequestError("Question not found");
			}

			if (question) {
				const answer = new Answer();
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
		let user: User | undefined;
		let ve: VirtualEntity | undefined;
		try {
			user = await this.userRepository.findOne(user_id, {
				relations: ["organisation"],
			});
		} catch (err) {
			console.log(err);
			throw new BadRequestError("User not found");
		}

		try {
			ve = await this.virtualEntityRepository.findOne(request.id, {
				relations: ["organisation"],
			});
		} catch (err) {
			throw new BadRequestError("Virtual entity not found");
		}
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
			throw new BadRequestError("User does not belong to organisation");
	}

	/**
	 * @description This function will get all the public virtual entities
	 * @returns {GVEs_VirtualEntity[]}
	 * @throws {InternalServerError}
	 */
	async GetPublicVirtualEntities(): Promise<GVEs_VirtualEntity[]> {
		try {
			const source_entities = await this.virtualEntityRepository.find({
				where: { public: true },
				relations: ["model"],
			});
			return source_entities.map((value) => {
				const entity: GVEs_VirtualEntity = {
					id: value.id,
					title: value.title,
					description: value.description,
				};
				if (value.model) {
					const model: GVEs_Model = {
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
			const user = await this.userRepository.findOne(user_id, {
				relations: ["organisation"],
			});
			if (!user) throw new BadRequestError("User not found");

			//A better query would be to get the organisation and then get all the virtual entities of that organisation
			return await this.virtualEntityRepository.find({
				where: { organisation: user.organisation, public: false },
				relations: ["model"],
			});
		} catch (err) {
			console.log(err);
			throw new BadRequestError("User not found");
		}
	}

	/**
	 * @description This function will get all the quizes of a lesson
	 * @param {GetQuizesByLessonRequest} request
	 * @returns {Promise<GetQuizesByLessonResponse>}
	 * @throws {BadRequestError}
	 */
	async GetQuizesByLesson(
		request: GetQuizesByLessonRequest,
		userId: number
	): Promise<GetQuizesByLessonResponse> {
		let lesson: Lesson | undefined;
		let user: User | undefined;
		try {
			lesson = await this.lessonRepository.findOne(request.id, {
				relations: [
					"virtualEntities",
					"virtualEntities.quiz",
					"virtualEntities.quiz.questions",
				],
			});
			console.log(lesson);

			user = await this.userRepository.findOne(userId, {
				relations: ["student", "student.grades", "student.grades.quiz"],
			});

			if (!lesson) throw new BadRequestError("Lesson not found");
			if (!user) throw new BadRequestError("User not found");

			//Get only the virtual entites that have a quiz defined then get all the quizes of those virtual entities
			const virtualEntities: VirtualEntity[] =
				lesson.virtualEntities.filter(
					(entity) => entity.quiz !== undefined
				);
			const quizes: Quiz[] = virtualEntities.map(
				(entity) => entity.quiz!
			);
			const quizesAnswered = user.student.grades.map((grades) => {
				return grades.quiz.id;
			});
			return {
				data: quizes.map((quiz) => ({ ...quiz })),
				answeredQuiz_ids: quizesAnswered,
			};
		} catch (err) {
			throw err;
		}
	}
}
