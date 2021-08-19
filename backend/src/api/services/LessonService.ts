import { CreateLessonRequest } from "../models/lesson/CreateLessonRequest";
import { GetLessonsBySubjectResponse } from "../models/lesson/GetLessonsBySubjectResponse";
import { Lesson } from "../database/Lesson";
import { Repository } from "typeorm";
import { GetLessonsBySubjectRequest } from "../models/lesson/GetLessonsBySubjectRequest";
import { Subject } from "../database/Subject";
import { handleSavetoDBErrors } from "../helper/ErrorCatch";
import { AddVirtualEntityToLessonRequest } from "../models/lesson/AddVirtualEntityToLessonRequest";
import { VirtualEntity } from "../database/VirtualEntity";
import { Service } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import { BadRequestError } from "routing-controllers";
let statusRes: any = {
	message: "",
	type: "fail",
};
@Service()
export class LessonService {
	constructor(
		@InjectRepository(Lesson) private lessonRepository: Repository<Lesson>,
		@InjectRepository(Subject)
		private subjectRepository: Repository<Subject>,
		@InjectRepository(VirtualEntity)
		private virtualEntityRepository: Repository<VirtualEntity>
	) {}
/**
 * @description This endpooint allows a educator to create a lesson for a subject 
 * 1. It checks if the subject for the lesson that the user is creating exists 
 * 2. if it does it instantioates the lesson and saves to the DB  
 * @param {CreateLessonRequest} request
 * @returns {*} 
 * @memberof LessonService
 */
public async CreateLesson(request: CreateLessonRequest) {
		// Set all attributes of a lesson
		let lesson: Lesson = new Lesson();
		lesson.title = request.title;
		lesson.description = request.description;
		lesson.virtualEntities = [];
		//If the lesson start and end timestamps are invalid, set them to null
		// lesson.startTime = new Date(request.startTime) ?? null;
		// lesson.endTime = new Date(request.endTime) ?? null;

		//let subjectRepository = getRepository(Subject);
		// search for subject with the givem id
		let subject = await this.subjectRepository.findOne(request.subjectId, {
			relations: ["lessons"],
		});
		if (subject) {
			lesson.subject = subject;
			// set add the lesson to the subject
			let savedLesson: Lesson;
			try {
				savedLesson = await this.lessonRepository.save(lesson);
				return { id: savedLesson.id };
			} catch (err) {
				throw handleSavetoDBErrors(err);
			}
		} else {
			throw new BadRequestError("Subject does not exist");
		}
	}
/**
 * @description This endpoint allows a user to get information about a lesson by specifying the subject id 
 * 1. Checks if the subject exists for specified id 
 * 2. if  it does it returns the asssociated information of the subject 
 * @param {GetLessonsBySubjectRequest} request
 * @returns {*} 
 * @memberof LessonService
 */
public async GetLessonsBySubject(request: GetLessonsBySubjectRequest) {
		let subject: Subject | undefined;
		try {
			subject = await this.subjectRepository.findOne(request.subjectId,{ relations: ["lessons"] });
		} catch (err) {
			throw new BadRequestError("Subject does not exist");
		}
		if (subject) {
			let lessons = subject.lessons;
			let LessonsData: GetLessonsBySubjectResponse = {
				data: lessons,
				statusMessage: "Successful",
			};
			return LessonsData;
		} else throw new BadRequestError("Subject does not exist");
	}
/**
 * @description This endpoint allows educators to add virtual entities to a lesson  by soecifying the lesson id 
 * 1. Two checks occur, one is o check if the lesson exists for specified Lesson 
 *                      two is to check if virtual enttiy already exists in the lesson 
 * 2. if those checks passed then the virtual entity id added to the lesson 
 * @param {AddVirtualEntityToLessonRequest} request
 * @returns {*} 
 * @memberof LessonService
 */
async AddVirtualEntityToLesson(request: AddVirtualEntityToLessonRequest) {
		let lesson = await this.lessonRepository.findOne(request.lessonId, {
			relations: ["virtualEntities"],
		});
		let virtualEntity = await this.virtualEntityRepository.findOne(
			request.virtualEntityId
		);

		if (!lesson) throw new BadRequestError("Lesson does not exist"); 
		if (!virtualEntity) throw new BadRequestError("Virtual Entity does not exist");
		if (lesson.virtualEntities.find(e => e.id === virtualEntity!.id) !== undefined) throw new BadRequestError("Virtual Entity has already been added");

		lesson.virtualEntities.push(virtualEntity);
		try {
			await this.lessonRepository.save(lesson);
			return "ok";
		} catch (err) {
			throw handleSavetoDBErrors(err);
		}
	}
}
