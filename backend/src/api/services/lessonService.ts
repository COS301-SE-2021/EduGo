import { CreateLessonRequest } from "../models/lesson/CreateLessonRequest";
import { GetLessonsBySubjectResponse } from "../models/lesson/GetLessonsBySubjectResponse";
import { Lesson } from "../database/Lesson";
import { getConnection } from "typeorm";
import { GetLessonsBySubjectRequest } from "../models/lesson/GetLessonsBySubjectRequest";
import { Subject } from "../database/Subject";
import { User } from "../database/User";
import { handleSavetoDBErrors } from "../helper/ErrorCatch";
import { NonExistantItemError } from "../errors/NonExistantItemError";
let statusRes: any = {
	message: "",
	type: "fail",
};

export class LessonService {
	public async createLesson(request: CreateLessonRequest) {
		if (
			request.title == null ||
			request.description == null ||
			request.subjectId == null ||
			request.startTime == null ||
			request.endTime == null
		) {
			statusRes.message = "Missing parameters";
			statusRes.type = "fail";
			return statusRes;
		} else {
			// Set all attributes of a lesson
			let conn = getConnection();
			let lesson: Lesson = new Lesson();
			lesson.title = request.title;
			lesson.description = request.description;
			lesson.virtualEntities = [];
			//If the lesson start and end timestamps are invalid, set them to null
			lesson.startTime = new Date(request.startTime) ?? null;
			lesson.endTime = new Date(request.endTime) ?? null;

			let subjectRepository = conn.getRepository(Subject);
			// search for subject with the givem id
			return subjectRepository
				.findOne(request.subjectId, {relations: ["lessons"]})
				.then((subject) => {
					if (subject) {
						subject.lessons.push(lesson);
						// set add the lesson to the subject
						return subjectRepository
							.save(subject)
							.then((value) => {
								return { id: lesson.id };
							})
							.catch((err) => {
								throw handleSavetoDBErrors(err);
							});
					} else {
						throw new NonExistantItemError("Subject Doesn't exixt");
					}
				});
		}
	}

	public async GetLessonsBySubject(request: GetLessonsBySubjectRequest) {
		if (request.subjectId == null) {
			statusRes.message =
				"SubjectId not provided" + JSON.stringify(request);
			return statusRes;
		} else {
			let conn = getConnection();
			let subjectRepository = conn.getRepository(Subject);
			return subjectRepository
				.findOne(request.subjectId, { relations: ["lessons"] })
				.then((subject) => {
					if (subject) {
						let lessons = subject.lessons;
						let LessonsData: GetLessonsBySubjectResponse = {
							data: lessons,
							statusMessage: "Successful",
						};
						return LessonsData;
					} else {
						statusRes.message = "The Subject doesn't exist";
						statusRes.type = "fail";
						return statusRes;
					}
				})
				.catch(() => {
					statusRes.message =
						"There was an error getting lessons for subjectId provided";
					statusRes.type = "fail";
					return statusRes;
				});
		}
	}
}