import { CreateSubjectRequest } from "../models/subject/CreateSubjectRequest";
import { Repository } from "typeorm";
import { Subject } from "../database/Subject";
import { GetSubjectsByUserResponse } from "../models/subject/GetSubjectsByUserResponse";
import { Organisation } from "../database/Organisation";
import { CreateSubjectResponse } from "../models/subject/CreateSubjectResponse";
import { User } from "../database/User";
import { getUserDetails } from "../helper/auth/Userhelper";
import { handleSavetoDBErrors } from "../helper/ErrorCatch";
import { Educator } from "../database/Educator";
import { Student } from "../database/Student";
import { Service } from "typedi";
import { InjectRepository } from "typeorm-typedi-extensions";
import {
	BadRequestError,
	InternalServerError,
	NotFoundError,
} from "routing-controllers";
import { Subject as ResponseSubject } from "../models/subject/Default";

@Service()
export class SubjectService {
	@InjectRepository(Subject) private subjectRepository: Repository<Subject>;
	@InjectRepository(User) private userRepository: Repository<User>;
	@InjectRepository(Organisation)
	private organisationRepository: Repository<Organisation>;
	@InjectRepository(Educator)
	private educatorRepository: Repository<Educator>;
	@InjectRepository(Student) private studentRepository: Repository<Student>;
/**
 * @description THis allows a n educator to create a subject by specifying associated information 
 * and it also requires a link to a photo which will the display picture of that image 
 * 
 * @param {CreateSubjectRequest} request
 * @param {number} user_id
 * @param {string} imageLink
 * @returns  {Promise<CreateSubjectResponse>}
 * @memberof SubjectService
 */
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

		console.log(userDetails.educator.id);

		let subject: Subject = new Subject();
		subject.title = request.title;
		subject.grade = request.grade;
		subject.image = imageLink;
		userDetails.educator.subjects;
		let org: Organisation | undefined;
		try {
			org = await this.organisationRepository.findOne(
				userDetails.organisation.id
			);
		} catch (err) {
			throw new BadRequestError("Could not find organisation");
		}

		if (!org) throw new BadRequestError("Could not find organisation");

		subject.organisation = org;

		let user: User | undefined;
		try {
			user = await this.userRepository.findOne(userDetails.educator.id, {
				relations: ["educator"],
			});
		} catch (err) {
			throw new BadRequestError("Could not find user");
		}

		if (user && user.educator) {
			subject.educators = [];
			subject.educators.push(user.educator);
			subject.students = [];
			subject.unverifiedUsers = [];
			subject.lessons = [];

			let savedSubject: Subject;
			try {
				savedSubject = await this.subjectRepository.save(subject);
				let response: CreateSubjectResponse = { id: savedSubject.id };
				return response;
			} catch (err) {
				throw handleSavetoDBErrors(err);
			}
		}
		throw new NotFoundError("Could not find educator user");
	}
/**
 * @description This returns the information about all the subjects that a user takes
 * @param {number} user_id
 * @returns  {Promise<GetSubjectsByUserResponse>}
 * @memberof SubjectService
 */
async GetSubjectsByUser(
		user_id: number
	): Promise<GetSubjectsByUserResponse> {
		//TODO - use the educator.subjects or the student.subjects relations
		let user: User | undefined;
		try {
			user = await this.userRepository.findOne(user_id, {
				relations: [
					"educator",
					"educator.subjects",
					"student",
					"student.subjects",
					"student.subjects.educators.user",
					"student.subjects.educators",
				],
			});
		} catch (err) {
			throw new BadRequestError("Could not find error");
		}

		console.log(user);

		if (!user) throw new BadRequestError("Could not find user");

		if (user.educator) {
			let obj = {
				data: user.educator.subjects.map((value) => {
					return {
						id: value.id,
						title: value.title,
						grade: value.grade,
						image: value.image,
					};
				}),
			};

			return obj;
		} else if (user.student) {
			console.log(user.student);
			return {
				data: await user.student.subjects.map((subject) => {
					console.log(subject.educators[0].user.firstName);
					return {
						id: subject.id,
						title: subject.title,
						grade: subject.grade,
						image: subject.image,
						educatorName: subject.educators[0].user.firstName,
					};
				}),
			};
		}

		throw new InternalServerError("User not a student nor a educator");
	}
}
