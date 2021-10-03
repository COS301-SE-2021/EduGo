import "reflect-metadata";
import { VirtualEntity } from "../../../database/VirtualEntity";
import { Student } from "../../../database/Student";
import { User } from "../../../database/User";
import { Question } from "../../../database/Question";
import { Quiz } from "../../../database/Quiz";
import { Lesson } from "../../../database/Lesson";
import {
	mock,
	instance,
	when,
	reset,
	anything,
	verify,
	capture,
} from "ts-mockito";
import { Repository } from "typeorm";
import { VirtualEntityService } from "../../../services/VirtualEntityService";
import { VirtualEntityController } from "../../virtualEntityController";
import { CreateVirtualEntityRequest } from "../../../models/virtualEntity/CreateVirtualEntityRequest";
import { InternalServerError, NotFoundError } from "routing-controllers";
import { GetVirtualEntityRequest } from "../../../models/virtualEntity/GetVirtualEntityRequest";
import { TogglePublicRequest } from "../../../models/virtualEntity/TogglePublicRequest";
import { GetQuizesByLessonRequest } from "../../../models/virtualEntity/GetQuizesByLessonRequest";
import { Organisation } from "../../../database/Organisation";
import { FileManagement } from "../../../helper/File";
import azureStorage from "azure-storage";
import { ExternalRequests } from "../../../../api/helper/ExternalRequests";

const mockedVirtualEntityRepository: Repository<VirtualEntity> =
	mock(Repository);
const virtualEntityRepository: Repository<VirtualEntity> = instance(
	mockedVirtualEntityRepository
);

const mockedQuizRepository: Repository<Quiz> = mock(Repository);
const quizRepository: Repository<Quiz> = instance(mockedQuizRepository);

const mockedQuestionRepository: Repository<Question> = mock(Repository);
const questionRepository: Repository<Question> = instance(
	mockedQuestionRepository
);

const mockedUserRepository: Repository<User> = mock(Repository);
const userRepository: Repository<User> = instance(mockedUserRepository);

const mockedStudentRepository: Repository<Student> = mock(Repository);
const studentRepository: Repository<Student> = instance(
	mockedStudentRepository
);

const mockedLessonRepository: Repository<Lesson> = mock(Repository);
const lessonRepository: Repository<Lesson> = instance(mockedLessonRepository);

const mockedAzureBlobService = mock(azureStorage.BlobService);
const azureBlobService = instance(mockedAzureBlobService);

const mockedExternalRequest: ExternalRequests = mock(ExternalRequests);
const externalRequest = instance(mockedExternalRequest);

const virtualEntityService: VirtualEntityService = new VirtualEntityService(
	virtualEntityRepository,
	quizRepository,
	questionRepository,
	userRepository,
	studentRepository,
	lessonRepository,
	externalRequest
);

const fileManagement: FileManagement = new FileManagement(azureBlobService);

const virtualEntityController: VirtualEntityController =
	new VirtualEntityController(virtualEntityService, fileManagement, externalRequest);

const organisation: Organisation = new Organisation();
organisation.id = 1;

const studentUser: User = new User();
studentUser.id = 1;
studentUser.firstName = "Test";
studentUser.lastName = "User";
studentUser.email = "test@email.com";
studentUser.username = "testUser";
studentUser.student = new Student();
studentUser.student.id = 1;
studentUser.student.subjects = [];
studentUser.organisation = organisation;

describe("Virtual Entity controller integration tests", () => {
	beforeEach(() => {
		reset(mockedVirtualEntityRepository);
		reset(mockedQuizRepository);
		reset(mockedQuestionRepository);
		reset(mockedUserRepository);
		reset(mockedStudentRepository);
		reset(mockedLessonRepository);

		when(mockedUserRepository.findOne(anything(), anything())).thenResolve(
			studentUser
		);
		when(mockedUserRepository.findOne(anything())).thenResolve(studentUser);
	});

	describe("Create Virtual Entity", () => {
		const request: CreateVirtualEntityRequest = {
			title: "A Virtual Entity",
			description: [],
			public: true,
			quiz: {
				questions: [
					{
						question: "A Question",
						correctAnswer: "A Correct Answer",
						options: ["A", "B", "C", "D"],
						type: "TrueFalse",
					},
				],
			},
		};

		it("should successfully create a new virtual entity", async () => {
			const virtualEntity: VirtualEntity = new VirtualEntity();
			virtualEntity.id = 1;

			when(mockedVirtualEntityRepository.save(anything())).thenResolve(
				virtualEntity
			);

			const response = await virtualEntityController.CreateVirtualEntity(
				request,
				studentUser.id
			);
			expect(response.id).toBe(1);
			verify(mockedVirtualEntityRepository.save(anything())).once();

			const [arg] = capture(mockedVirtualEntityRepository.save).last();
			expect(arg).toBeInstanceOf(VirtualEntity);
			expect(arg.quiz).toBeInstanceOf(Quiz);
			expect(arg.quiz!.questions![0]).toBeInstanceOf(Question);
			expect(arg.title).toBe("A Virtual Entity");
			expect(arg.quiz!.questions![0].question).toBe("A Question");
		});

		it("should throw a save error when unsuccessfully creating a new virtual entity", async () => {
			when(mockedVirtualEntityRepository.save(anything())).thenReject(
				new Error("Some Error")
			);
			expect(() =>
				virtualEntityController.CreateVirtualEntity(
					request,
					studentUser.id
				)
			).rejects.toThrow(InternalServerError);
		});
	});

	describe("Get Virtual Entity", () => {
		const request: GetVirtualEntityRequest = {
			id: 1,
		};

		it("should successfully get a virtual entity", async () => {
			const virtualEntity: VirtualEntity = new VirtualEntity();
			virtualEntity.id = 1;
			virtualEntity.title = "A Virtual Entity";
			virtualEntity.description = [];
			when(
				mockedVirtualEntityRepository.findOne(anything(), anything())
			).thenResolve(virtualEntity);

			const response = await virtualEntityController.GetVirtualEntity(
				request
			);
			expect(response.id).toBe(1);
			verify(
				mockedVirtualEntityRepository.findOne(anything(), anything())
			).once();
		});

		it("should throw an error if virtual entity does not exist", async () => {
			when(
				mockedVirtualEntityRepository.findOne(anything(), anything())
			).thenResolve(undefined);
			expect(() =>
				virtualEntityController.GetVirtualEntity(request)
			).rejects.toThrow(NotFoundError);
		});
	});

	describe("Toggle Public", () => {
		const request: TogglePublicRequest = {
			id: 1,
		};

		it("successfully make a private virtual entity public", async () => {
			const virtualEntity: VirtualEntity = new VirtualEntity();
			virtualEntity.id = 1;
			virtualEntity.public = false;
			virtualEntity.organisation = organisation;

			when(
				mockedUserRepository.findOne(anything(), anything())
			).thenResolve(studentUser);
			when(
				mockedVirtualEntityRepository.findOne(anything(), anything())
			).thenResolve(virtualEntity);
			when(mockedVirtualEntityRepository.save(anything())).thenResolve(
				virtualEntity
			);

			const response = await virtualEntityController.TogglePublic(
				request,
				studentUser.id
			);
			expect(response.public).toBe(true);
			verify(
				mockedVirtualEntityRepository.findOne(anything(), anything())
			).once();
			verify(mockedVirtualEntityRepository.save(anything())).once();

			const [arg] = capture(mockedVirtualEntityRepository.save).last();
			expect(arg.public).toBe(true);
		});

		it("successfully make a public virtual entity private", async () => {
			const virtualEntity: VirtualEntity = new VirtualEntity();
			virtualEntity.id = 1;
			virtualEntity.public = true;
			virtualEntity.organisation = organisation;

			when(
				mockedUserRepository.findOne(anything(), anything())
			).thenResolve(studentUser);
			when(
				mockedVirtualEntityRepository.findOne(anything(), anything())
			).thenResolve(virtualEntity);
			when(mockedVirtualEntityRepository.save(anything())).thenResolve(
				virtualEntity
			);

			const response = await virtualEntityController.TogglePublic(
				request,
				studentUser.id
			);
			expect(response.public).toBe(false);
			verify(
				mockedVirtualEntityRepository.findOne(anything(), anything())
			).once();
			verify(mockedVirtualEntityRepository.save(anything())).once();

			const [arg] = capture(mockedVirtualEntityRepository.save).last();
			expect(arg.public).toBe(false);
		});
	});

	describe("Get Public Virtual Entities", () => {
		it("should successfully return a list of public virtual entities", async () => {
			const virtualEntities: VirtualEntity[] = [1, 2, 3, 4].map((id) => {
				const virtualEntity: VirtualEntity = new VirtualEntity();
				virtualEntity.id = id;
				virtualEntity.public = true;
				return virtualEntity;
			});

			when(mockedVirtualEntityRepository.find(anything())).thenResolve(
				virtualEntities
			);

			const response =
				await virtualEntityController.GetPublicVirtualEntities();
			expect(response.length).toBe(4);
			expect(response[0].id).toBe(1);
			expect(response[1].id).toBe(2);
			expect(response[2].id).toBe(3);
			expect(response[3].id).toBe(4);
			verify(mockedVirtualEntityRepository.find(anything())).once();
		});
	});

	describe("Get Private Virtual Entities", () => {
		it("should successfully return a list of private virtual entities", async () => {
			const virtualEntities: VirtualEntity[] = [1, 2, 3, 4].map((id) => {
				const virtualEntity: VirtualEntity = new VirtualEntity();
				virtualEntity.id = id;
				virtualEntity.public = false;
				return virtualEntity;
			});

			when(
				mockedUserRepository.findOne(anything(), anything())
			).thenResolve(studentUser);
			when(mockedVirtualEntityRepository.find(anything())).thenResolve(
				virtualEntities
			);

			const response =
				await virtualEntityController.GetPrivateVirtualEntities(
					studentUser.id
				);
			expect(response.length).toBe(4);
			expect(response[0].id).toBe(1);
			expect(response[1].id).toBe(2);
			expect(response[2].id).toBe(3);
			expect(response[3].id).toBe(4);
			verify(mockedVirtualEntityRepository.find(anything())).once();
		});
	});

	describe("Get Quizzes By Lesson", () => {
		const request: GetQuizesByLessonRequest = {
			id: 1,
		};

		it.skip("should successfully return a list of quizzes", async () => {
			const virtualEntities: VirtualEntity[] = [1, 2, 3].map((id) => {
				const virtualEntity: VirtualEntity = new VirtualEntity();
				virtualEntity.id = id;
				const quiz: Quiz = new Quiz();
				quiz.id = id;
				const questions: Question[] = [1, 2].map((id) => {
					const question: Question = new Question();
					question.id = id;
					question.question = "A Question";
					return question;
				});
				quiz.questions = questions;
				virtualEntity.quiz = quiz;
				return virtualEntity;
			});

			const lesson: Lesson = new Lesson();
			lesson.id = 1;
			lesson.virtualEntities = virtualEntities;

			when(
				mockedLessonRepository.findOne(anything(), anything())
			).thenResolve(lesson);
			const response = await virtualEntityController.GetQuizesByLesson(
				request,
				1
			);

			expect(response.data.length).toBe(3);
			expect(response.data[0].questions.length).toBe(2);
			verify(
				mockedLessonRepository.findOne(anything(), anything())
			).once();
		});
	});
});
