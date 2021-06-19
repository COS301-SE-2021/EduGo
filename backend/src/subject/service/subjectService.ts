import * as model from "../model/apiModels";
import { ApiResponse } from "../../models/apiResponse";
import { CreateSubjectRequest } from "../model/CreateSubjectRequest";
import { createConnection, getConnection } from "typeorm";
import { Subject } from "../../database/entity/Subject";
import { GetSubjectsByEducatorRequest } from "../model/GetSubjectsByEducatorRequest";
import { GetLessonsBySubjectResponse } from "../model/GetSubjectsByEducatorResponse";

//import {client} from '../../index'

let statusRes: ApiResponse = {
	message: "",
	type: "fail",
};

export async function createSubject(request: CreateSubjectRequest) {
	if (
		request.title == null ||
		request.educatorId == null ||
		request.description == null
	) {
		statusRes.message = "Missing parameters";
		statusRes.type = "fail";
		return statusRes;
	} else {
		let conn = getConnection();
		let subject: Subject = new Subject();
		subject.title = request.title;
		subject.description = request.description;
		subject.educatorId = request.educatorId;
		subject.lessons = [];
		let subjectRepository = conn.getRepository(Subject);

		return subjectRepository
			.save(subject)
			.then((value) => {
				statusRes.message = `Successfully added subject `;
				statusRes.type = "success";
				return statusRes;
			})
			.catch(() => {
				statusRes.message =
					"There was an error adding the subject to the database";
				statusRes.type = "fail";
				return statusRes;
			});
	}
}

export async function GetSubjectsByEducator(
	request: GetSubjectsByEducatorRequest
) {
	if (request.educatorId == null) {
		statusRes.message = "educatorId not provided";
		return statusRes;
	} else {
		let conn = await getConnection();
		let subjectRepository = conn.getRepository(Subject);
		return subjectRepository
			.find({ where: { educatorId: request.educatorId } })
			.then((subjects) => {
				if (subjects.length > 0) {
					let LessonsData: GetLessonsBySubjectResponse = {
						data: subjects,
						statusMessage: "Successful",
					};
					return LessonsData;
				} else {
					statusRes.message =
						"EducatorId invalid or Educator hasn't created subjects";
					statusRes.type = "fail";
					return statusRes;
				}
			})
			.catch(() => {
				statusRes.message =
					"There was an error getting subjects for educators provided";
				statusRes.type = "fail";
				return statusRes;
			});
	}
}