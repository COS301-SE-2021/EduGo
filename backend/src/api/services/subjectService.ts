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
import { getUserDetails } from "../helper/auth/Userhelper";
import { handleErrors, handleSavetoDBErrors } from "../helper/ErrorCatch";

//import {client} from '../../index'

let statusRes: any = {
	message: "",
	type: "fail",
};

export class SubjectService {
	async CreateSubject(
		request: CreateSubjectRequest,
		user_id: number
	){
		// get user information to use for the request
		let userDetails: User;
		try {
			userDetails = await getUserDetails(user_id);
		} catch (error) {
			throw error;
			
		}

		let subjectRepository = getRepository(Subject);
		let subject: Subject = new Subject();
		subject.title = request.title;
		subject.grade = request.grade;

		// adding the subject to educators organisation
		userDetails.organisation.subjects.push(subject);

		//add the educator to the subject
		subject.educators.push(userDetails.educator);

		subjectRepository
			.save(subject)
			.then((subject) => {
				let response: CreateSubjectResponse = {
					id: subject.id,
				};
				return response;
			})
			.catch((error) => {
				handleSavetoDBErrors(error);
			});
	}

	async GetSubjectsByEducator(
		request: GetSubjectsByEducatorRequest
	): Promise<GetSubjectsByEducatorResponse> {
		let userRepository = getRepository(User);

		return userRepository
			.findOne(request.educator_id, {
				relations: ["educator", "educator.subjects"],
			})
			.then((user) => {
				if (user && user.educator) {
					let subjects: GSBE_Subject[] = user.educator.subjects.map(
						(value) => {
							return {
								id: value.id,
								title: value.title,
								grade: value.grade,
							};
						}
					);
					return { data: subjects };
				}
				throw new DatabaseError("Educator subjects could not be found");
			});
	}
}
