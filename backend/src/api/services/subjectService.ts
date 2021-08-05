import { CreateSubjectRequest } from "../models/subject/CreateSubjectRequest";
import { getConnection, getRepository } from "typeorm";
import { Subject } from "../database/Subject";
import { GetSubjectsByUserRequest } from "../models/subject/GetSubjectsByUserRequest";
import { GetSubjectsByUserResponse } from "../models/subject/GetSubjectsByUserResponse";
import { Organisation } from "../database/Organisation";
import { CreateSubjectResponse } from "../models/subject/CreateSubjectResponse";
import { User } from "../database/User";
import { DatabaseError } from "../errors/DatabaseError";
import { Subject as GSBE_Subject } from "../models/subject/Default";
import { getUserDetails } from "../helper/auth/Userhelper";
import { handleErrors } from "../helper/ErrorCatch";
import { Educator } from "../database/Educator";
import { NonExistantItemError } from "../errors/NonExistantItemError";
import { Student } from "../database/Student";

//import {client} from '../../index'

export class SubjectService {
	async CreateSubject(
		request: CreateSubjectRequest,
		user_id: number,
		imageLink: string
	): Promise<CreateSubjectResponse> {
		// get user information to use for the request
		let userDetails: User;
		try {
			userDetails = await getUserDetails(user_id);
		} catch (error) {
			throw error;
		}

		let subjectRepository = getRepository(Subject);
		let userRepository = getRepository(User);
		let organisationRepository = getRepository(Organisation);

		let subject: Subject = new Subject();
		subject.title = request.title;
		subject.grade = request.grade;
		subject.image = imageLink;
		return organisationRepository
			.findOne(userDetails.organisation.id)
			.then(async (org) => {
				if (org) {
					subject.organisation = org;

					const user = await userRepository.findOne(
						userDetails.educator.id,
						{
							relations: ["educator"],
						}
					);
					if (user && user.educator) {
						subject.educators = [user.educator];
						subject.students = [];
						subject.unverifiedUsers = [];
						subject.lessons = [];

						return subjectRepository
							.save(subject)
							.then((subject) => {
								let response: CreateSubjectResponse = {
									id: subject.id,
								};
								return response;
							});
					}
					throw new DatabaseError("Could not find educator user");
				}
				throw new DatabaseError("Could not find organisation");
			});
	}

	async GetSubjectsByUser(
		request: GetSubjectsByUserRequest
	): Promise<GetSubjectsByUserResponse> {
		let userRepository = getRepository(User);

		return userRepository
			.findOne(request.user_id, {
				relations: ["educator", "student"],
			})
			.then(async (user) => {
				// if user is a educator then return the educators subjects
				if (user && user.educator) {
					try {
						let educatorData = await getRepository(
							Educator
						).findOne(user.educator.id, {
							relations: ["subjects"],
						});
						if (educatorData) {
							return { data: educatorData.subjects };
						}
					} catch (error) {
						throw error;
					}
				} else if (user && user.student) {
					try {
						let studentData = await getRepository(Student).findOne(
							user.educator.id,
							{
								relations: ["subjects"],
							}
						);
						if (studentData) {
							return { data: studentData.subjects };
						}
					} catch (error) {
						throw error;
					}
				}
				throw new DatabaseError("Educator subjects could not be found");
			});
	}

	//public mapSubjectDataFromDb(Subject);
}
