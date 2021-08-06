import { CreateSubjectRequest } from "../models/subject/CreateSubjectRequest";
import { Repository } from "typeorm";
import { Subject } from "../database/Subject";
import { GetSubjectsByUserRequest } from "../models/subject/GetSubjectsByUserRequest";
import { GetSubjectsByUserResponse } from "../models/subject/GetSubjectsByUserResponse";
import { Organisation } from "../database/Organisation";
import { CreateSubjectResponse } from "../models/subject/CreateSubjectResponse";
import { User } from "../database/User";
import { DatabaseError } from "../errors/DatabaseError";
import { getUserDetails } from "../helper/auth/Userhelper";
import { handleErrors, handleSavetoDBErrors } from "../helper/ErrorCatch";
import { Educator } from "../database/Educator";
import { Student } from "../database/Student";
import { Service } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";


//import {client} from '../../index'

@Service()
export class SubjectService {
	@InjectRepository(Subject) private subjectRepository: Repository<Subject>;
	@InjectRepository(User) private userRepository: Repository<User>;
	@InjectRepository(Organisation) private organisationRepository: Repository<Organisation>;
	@InjectRepository(Educator) private educatorRepository: Repository<Educator>;
	@InjectRepository(Student) private studentRepository: Repository<Student>;

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

		let subject: Subject = new Subject();
		subject.title = request.title;
		subject.grade = request.grade;
		subject.image = imageLink;
		return this.organisationRepository
			.findOne(userDetails.organisation.id)
			.then(async (org) => {
				if (org) {
					subject.organisation = org;

					const user = await this.userRepository.findOne(
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

						return this.subjectRepository
							.save(subject)
							.then((subject) => {
								let response: CreateSubjectResponse = {
									id: subject.id,
								};
								return response;
							})
							.catch(err => {
								throw handleSavetoDBErrors(err);
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

		return this.userRepository
			.findOne(request.user_id, {
				relations: ["educator", "student"],
			})
			.then(async (user) => {
				// if user is a educator then return the educators subjects
				if (user && user.educator) {
					try {
						let educatorData = await this.educatorRepository.findOne(user.educator.id, {
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
						let studentData = await this.studentRepository.findOne(
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
