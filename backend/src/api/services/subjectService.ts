
import { CreateSubjectRequest } from "../models/subject/CreateSubjectRequest";
import { getConnection, getRepository } from "typeorm";
import { Subject } from "../database/Subject";
import { GetSubjectsByEducatorRequest } from "../models/subject/GetSubjectsByEducatorRequest";
import { GetSubjectsByEducatorResponse } from "../models/subject/GetSubjectsByEducatorResponse";
import { Organisation } from "../database/Organisation";
import { CreateSubjectResponse } from "../models/subject/CreateSubjectResponse";
import { User } from "../database/User";
import { DatabaseError } from "../errors/DatabaseError";
import { Subject as GSBE_Subject } from "../models/subject/Default";

//import {client} from '../../index'

let statusRes: any = {
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

