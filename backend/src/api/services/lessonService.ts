import { CreateLessonRequest } from "../models/lesson/CreateLessonRequest";
import { GetLessonsBySubjectResponse } from "../models/lesson/GetLessonsBySubjectResponse";
import { Lesson } from "../database/Lesson";
import { getConnection } from "typeorm";
import { GetLessonsBySubjectRequest } from "../models/lesson/GetLessonsBySubjectRequest";
import { Subject } from "../database/Subject";
import { User } from "../database/User";
let statusRes: any = {
	message: "",
	type: "fail",
};


export class LessonService{
	public async createLesson(request: CreateLessonRequest) {
		if (
			request.title == null ||
			request.date == null ||
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
			let user: User = new User();
			lesson.title = request.title;
			lesson.description = request.description;
			lesson.date = request.date;
			lesson.virtualEntities = [];
			lesson.startTime = request.startTime;
			lesson.endTime = request.endTime;
	
			let subjectRepository = conn.getRepository(Subject);
			// search for subject with the givem id
			return subjectRepository.findOne(request.subjectId).then((subject) => {
				if (subject) {
					subject.lessons = [lesson];
					// set add the lesson to the subject
					return subjectRepository
						.save(subject)
						.then((value) => {
							statusRes.message = `Successfully added lesson `;
							statusRes.type = "success";
							return statusRes;
						})
						.catch((err) => {
							statusRes.message = err.message;
							statusRes.type = "fail";
							return statusRes;
						});
				} else {
					statusRes.message = "Subject Doesn't Exist";
					statusRes.type = "fail";
					return statusRes;
				}
			});
		}
	}
	
	public async GetLessonsBySubject(request: GetLessonsBySubjectRequest) {
		if (request.subjectId == null) {
			statusRes.message = "SubjectId not provided" + JSON.stringify(request);
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

