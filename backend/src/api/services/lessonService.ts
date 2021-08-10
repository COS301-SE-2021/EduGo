import { CreateLessonRequest } from "../models/lesson/CreateLessonRequest";
import { GetLessonsBySubjectResponse } from "../models/lesson/GetLessonsBySubjectResponse";
import { Lesson } from "../database/Lesson";
import { Repository} from "typeorm";
import { GetLessonsBySubjectRequest } from "../models/lesson/GetLessonsBySubjectRequest";
import { Subject } from "../database/Subject";
import { User } from "../database/User";
import { handleSavetoDBErrors } from "../helper/ErrorCatch";
import { NonExistantItemError } from "../errors/NonExistantItemError";
import { AddVirtualEntityToLessonRequest } from "../models/lesson/AddVirtualEntityToLessonRequest";
import { VirtualEntity } from "../database/VirtualEntity";
import { Service } from 'typedi'
import { InjectRepository } from "typeorm-typedi-extensions";
import { BadRequestError, InternalServerError } from "routing-controllers";
let statusRes: any = {
	message: "",
	type: "fail",
};
@Service()
export class LessonService {
	@InjectRepository(Lesson) private lessonRepository: Repository<Lesson>;
	@InjectRepository(Subject) private subjectRepository: Repository<Subject>;
	@InjectRepository(VirtualEntity) private virtualEntityRepository: Repository<VirtualEntity>;

	public async createLesson(request: CreateLessonRequest) {
		// Set all attributes of a lesson
		let lesson: Lesson = new Lesson();
		lesson.title = request.title;
		lesson.description = request.description;
		lesson.virtualEntities = [];
		//If the lesson start and end timestamps are invalid, set them to null
		lesson.startTime = new Date(request.startTime) ?? null;
		lesson.endTime = new Date(request.endTime) ?? null;

		//let subjectRepository = getRepository(Subject);
		// search for subject with the givem id
		return this.subjectRepository
			.findOne(request.subjectId, {relations: ["lessons"]})
			.then((subject) => {
				if (subject) {
					subject.lessons.push(lesson);
					// set add the lesson to the subject
					return this.subjectRepository
						.save(subject)
						.then((value) => {
							return { id: lesson.id };
						})
						.catch((err) => {
							throw handleSavetoDBErrors(err);
						});
				} else {
					throw new BadRequestError('Subject does not exist')
				}
		});
	}

	public async GetLessonsBySubject(request: GetLessonsBySubjectRequest) {
		if (request.subjectId == null) {
			statusRes.message =
				"SubjectId not provided" + JSON.stringify(request);
			return statusRes;
		} else {
			//let subjectRepository = getRepository(Subject);
			return this.subjectRepository
				.findOne(request.subjectId, { relations: ["lessons"] })
				.then((subject) => {
					if (subject) {
						let lessons = subject.lessons;
						let LessonsData: GetLessonsBySubjectResponse = {
							data: lessons,
							statusMessage: "Successful",
						};
						return LessonsData;
					} else throw new BadRequestError('Subject does not exist');
				})
				.catch(() => {
					throw new BadRequestError('Subject does not exist');
				});
		}
	}

	async AddVirtualEntityToLesson(request: AddVirtualEntityToLessonRequest) {
		let lesson = await this.lessonRepository.findOne(request.lessonId, {relations: ["virtualEntities"]});
		let virtualEntity = await this.virtualEntityRepository.findOne(request.virtualEntityId);
		if (lesson) {
			if (virtualEntity) {
				lesson.virtualEntities.push(virtualEntity);
				this.lessonRepository.save(lesson).then(() => {
					return true;
				})
				.catch((err) => {
					throw handleSavetoDBErrors(err);
				});
			}
			else throw new BadRequestError('Virtual Entity does not exist');
		}
		else throw new BadRequestError('Lesson does not exist');
	}
}