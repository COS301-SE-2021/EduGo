import { CreateSubjectRequest } from "../models/subject/CreateSubjectRequest";
import { Repository } from "typeorm";
import { Subject } from "../database/Subject";
import { GetSubjectsByUserResponse } from "../models/subject/GetSubjectsByUserResponse";
import { Organisation } from "../database/Organisation";
import { CreateSubjectResponse } from "../models/subject/CreateSubjectResponse";
import { User } from "../database/User";
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
import { DeleteSubjectRequest } from "../models/subject/DeleteSubjectRequest";

@Service()
export class SubjectService {
	constructor(
		@InjectRepository(Subject)
		private subjectRepository: Repository<Subject>,
		@InjectRepository(User) private userRepository: Repository<User>,
		@InjectRepository(Organisation)
		private organisationRepository: Repository<Organisation>,
		@InjectRepository(Educator)
		private educatorRepository: Repository<Educator>,
		@InjectRepository(Student)
		private studentRepository: Repository<Student>
	) {}

	async CreateSubject(
		request: CreateSubjectRequest,
		user_id: number,
		imageLink: string
	): Promise<CreateSubjectResponse> {
		// get user information to use for the request
		let user: User | undefined;
		try {

			userDetails = await this.userRepository.findOne(user_id, {
				relations: ["organisation", "educator", "student"],
			});

		} catch (error) {
			throw new InternalServerError(
				"There was an error getting the user"
			);
		}

		if (!user) throw new NotFoundError("Could not find user");

		const subject: Subject = new Subject();
		subject.title = request.title;
		subject.grade = request.grade;
		subject.image = imageLink;
		
		// let org: Organisation | undefined;
		// try {
		// 	org = await this.organisationRepository.findOne(
		// 		user.organisation.id
		// 	);
		// } catch (err) {
		// 	throw new BadRequestError("Could not find organisation");
		// }

		// if (!org) throw new BadRequestError("Could not find organisation");

		subject.organisation = user.organisation;

		// let user: User | undefined;
		// try {
		// 	user = await this.userRepository.findOne(userDetails.educator.id, {
		// 		relations: ["educator"],
		// 	});
		// } catch (err) {
		// 	throw new BadRequestError("Could not find user");
		// }

		if (user && user.educator) {
			subject.educators = [];
			subject.educators.push(user.educator);
			subject.students = [];
			subject.unverifiedUsers = [];
			subject.lessons = [];

			let savedSubject: Subject;
			try {
				savedSubject = await this.subjectRepository.save(subject);
				const response: CreateSubjectResponse = { id: savedSubject.id };
				return response;
			} catch (err) {
				throw handleSavetoDBErrors(err);
			}
		}
		throw new NotFoundError("Could not find educator user");
	}

	async DeleteSubject(body: DeleteSubjectRequest): Promise<string> {
		try {
			await this.subjectRepository.delete({ id: body.id });
			return "ok";
		} catch (err) {
			console.log(err);
			throw new InternalServerError(
				"There was an error deleting the subject"
			);
		}
	}

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
			const obj = {
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
