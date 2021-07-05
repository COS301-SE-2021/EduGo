import * as model from "../model/apiModels";
import { ApiResponse } from "../../models/apiResponse";
import { CreateSubjectRequest } from "../model/CreateSubjectRequest";
import { createConnection, getConnection, getRepository } from "typeorm";
import { Subject } from "../../database/entity/Subject";
import { GetSubjectsByEducatorRequest } from "../model/GetSubjectsByEducatorRequest";
import { GetLessonsBySubjectResponse } from "../model/GetSubjectsByEducatorResponse";
import { Organisation } from "../../database/entity/Organisation";

//import {client} from '../../index'

let statusRes: ApiResponse = {
	message: "",
	type: "fail",
};

export async function createSubject(request: CreateSubjectRequest) {
	if (
		request.title == null ||
		request.educatorId == null
	) {
		statusRes.message = "Missing parameters"+JSON.stringify(request);
		statusRes.type = "fail";
		return statusRes;
	} else {
		let conn = getConnection();
		let subject: Subject = new Subject();
		subject.title = request.title;
		subject.lessons = [];
		subject.grade = request.grade;
		let subjectRepository = conn.getRepository(Subject);
		return getRepository(Organisation).findOne(request.organisationId).then(org => {
			if (org) {
				subject.organisation = org;
				return subjectRepository
					.save(subject)
					.then((value) => {
						statusRes.message = `Successfully added subject `;
						statusRes.type = "success";
						return statusRes;
					})
					.catch((err) => {
						statusRes.message =
							"There was an error adding the subject to the database";
						statusRes.type = "fail";
						console.log(err);
						return statusRes;
					});
			}
			throw new Error('')
		})
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
