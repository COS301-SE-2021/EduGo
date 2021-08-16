import { CreateSubjectRequest } from "../models/subject/CreateSubjectRequest";
import { Repository } from "typeorm";
import { Subject } from "../database/Subject";
import { GetSubjectsByUserRequest } from "../models/subject/GetSubjectsByUserRequest";
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

	async GetSubjectsByUser(
		user_id: number
	): Promise<GetSubjectsByUserResponse> {
		//TODO - use the educator.subjects or the student.subjects relations
		let user: User | undefined;
		try {
			user = await this.userRepository.findOne(user_id, {
				relations: ["educator", "student"],
			});
		} catch (err) {
			throw new BadRequestError("Could not find error");
		}

		if (user) {
			if (user.educator) {
				let educator: Educator | undefined;
				try {
					educator = await this.educatorRepository.findOne(
						user.educator.id,
						{ relations: ["subjects"] }
					);

					console.log(educator);
				} catch (err) {
					throw new BadRequestError("Could not find Educator");
				}
				if (!educator)
					throw new BadRequestError("Could not find Educator");

				let obj = {
					data: educator.subjects.map((value) => {
						console.log(value);

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
				let student: Student | undefined;

				try {
					student = await this.studentRepository.findOne(
						user.student.id,
						{ relations: ["subjects"] }
					);
				} catch (err) {
					throw new BadRequestError("Could not find Student");
				}
				if (!student)
					throw new BadRequestError("Could not find Student");

				return {
					data: student.subjects.map((value) => {
						return {
							id: value.id,
							title: value.title,
							grade: value.grade,
							image: value.image,
						};
					}),
				};
			} else
				throw new InternalServerError(
					"Could not determine of user is student or educator"
				);
		} else throw new BadRequestError("Could not find user");
	}
}
