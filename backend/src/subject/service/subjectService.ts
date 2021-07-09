import { ApiResponse } from "../../models/apiResponse";
import { CreateSubjectRequest } from "../model/CreateSubjectRequest";
import { getConnection, getRepository } from "typeorm";
import { Subject } from "../../database/entity/Subject";
import { GetSubjectsByEducatorRequest } from "../model/GetSubjectsByEducatorRequest";
import { GetSubjectsByEducatorResponse } from "../model/GetSubjectsByEducatorResponse";
import { Organisation } from "../../database/entity/Organisation";
import { CreateSubjectResponse } from "../model/CreateSubjectResponse";
import { User } from "../../database/entity/User";
import { DatabaseError } from "../../exceptions/DatabaseError";
import { Subject as GSBE_Subject } from "../model/Default";

//import {client} from '../../index'

let statusRes: ApiResponse = {
	message: "",
	type: "fail",
};

export class SubjectService {
	async CreateSubject(request: CreateSubjectRequest): Promise<CreateSubjectResponse> {
		let subjectRepository = getRepository(Subject);
		let userRepository = getRepository(User);
		let organisationRepository = getRepository(Organisation);

		let subject: Subject = new Subject();
		subject.title = request.title;
		subject.grade = request.grade;

		return organisationRepository.findOne(request.organisation_id).then(org => {
			if (org) {
				subject.organisation = org

				return userRepository.findOne(request.educator_id, {
					relations: ["educator"]
				}).then(user => {
					if (user && user.educator) {
						subject.educators = [user.educator]
						subject.students = []
						subject.unverifiedUsers = []
						subject.lessons = []

						return subjectRepository.save(subject).then(subject => {
							let response: CreateSubjectResponse = {
								id: subject.id
							}
							return response
						})
					}
					throw new DatabaseError('Could not find educator user')
				})
			}
			throw new DatabaseError('Could not find organisation')
		})

	}

	async GetSubjectsByEducator(request: GetSubjectsByEducatorRequest): Promise<GetSubjectsByEducatorResponse> {
		let userRepository = getRepository(User);

		return userRepository.findOne(request.educator_id, {
			relations: ['educator', 'educator.subjects']
		}).then(user => {
			if (user && user.educator) {
				let subjects: GSBE_Subject[] = user.educator.subjects.map(value => {
					return {
						id: value.id,
						title: value.title,
						grade: value.grade
					}
				})
				return {data: subjects}
			}
			throw new DatabaseError('Educator subjects could not be found')
		})
	}
}

// export async function GetSubjectsByEducator(
// 	request: GetSubjectsByEducatorRequest
// ) {
// 	if (request.educatorId == null) {
// 		statusRes.message = "educatorId not provided";
// 		return statusRes;
// 	} else {
// 		let conn = await getConnection();
// 		let subjectRepository = conn.getRepository(Subject);
// 		return subjectRepository
// 			.find({ where: { educatorId: request.educatorId } })
// 			.then((subjects) => {
// 				if (subjects.length > 0) {
// 					let LessonsData: GetLessonsBySubjectResponse = {
// 						data: subjects,
// 						statusMessage: "Successful",
// 					};
// 					return LessonsData;
// 				} else {
// 					statusRes.message =
// 						"EducatorId invalid or Educator hasn't created subjects";
// 					statusRes.type = "fail";
// 					return statusRes;
// 				}
// 			})
// 			.catch(() => {
// 				statusRes.message =
// 					"There was an error getting subjects for educators provided";
// 				statusRes.type = "fail";
// 				return statusRes;
// 			});
// 	}
// }

// export async function createSubject(request: CreateSubjectRequest) {
// 	if (
// 		request.title == null ||
// 		request.educator_id == null
// 	) {
// 		statusRes.message = "Missing parameters"+JSON.stringify(request);
// 		statusRes.type = "fail";
// 		return statusRes;
// 	} else {
// 		let conn = getConnection();
// 		let subject: Subject = new Subject();
// 		subject.title = request.title;
// 		subject.lessons = [];
// 		subject.grade = request.grade;
// 		let subjectRepository = conn.getRepository(Subject);
// 		return getRepository(Organisation).findOne(request.organisation_id).then(org => {
// 			if (org) {
// 				subject.organisation = org;
// 				return subjectRepository
// 					.save(subject)
// 					.then((value) => {
// 						statusRes.message = `Successfully added subject `;
// 						statusRes.type = "success";
// 						return statusRes;
// 					})
// 					.catch((err) => {
// 						statusRes.message =
// 							"There was an error adding the subject to the database";
// 						statusRes.type = "fail";
// 						console.log(err);
// 						return statusRes;
// 					});
// 			}
// 			throw new Error('')
// 		})
// 	}
// }
