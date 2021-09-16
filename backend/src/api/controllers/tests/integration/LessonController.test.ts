import "reflect-metadata";
import { Lesson } from "../../../database/Lesson";
import { Subject } from "../../../database/Subject";
import { VirtualEntity } from "../../..//database/VirtualEntity";
import {
	mock,
	instance,
	when,
	verify,
	anything,
	reset,
	capture,
} from "ts-mockito";
import { Repository } from "typeorm";
import { LessonService } from "../../../services/LessonService";
import { LessonController } from "../../lessonController";
import { CreateLessonRequest } from "../../../models/lesson/CreateLessonRequest";
import { GetLessonsBySubjectRequest } from "../../../models/lesson/GetLessonsBySubjectRequest";
import { AddVirtualEntityToLessonRequest } from "../../../models/lesson/AddVirtualEntityToLessonRequest";
import {
	Action,
	BadRequestError,
	createExpressServer,
	useContainer,
} from "routing-controllers";
import { Container } from "typedi";
import request from "supertest";
import { User } from "../../../database/User";
import { issueJWT } from "../../../helper/auth/utils";

const mockedLessonRepository: Repository<Lesson> = mock(Repository);
const lessonRepository: Repository<Lesson> = instance(mockedLessonRepository);

const mockedSubjectRepository: Repository<Subject> = mock(Repository);
const subjectRepository: Repository<Subject> = instance(
	mockedSubjectRepository
);

const mockedVirtualEntityRepository: Repository<VirtualEntity> =
	mock(Repository);
const virtualEntityRepository: Repository<VirtualEntity> = instance(
	mockedVirtualEntityRepository
);

const lessonService: LessonService = new LessonService(
	lessonRepository,
	subjectRepository,
	virtualEntityRepository
);

const validUser: User = new User();
validUser.id = 1;

// let {token: validToken} = issueJWT(validUser);

// Container.set(LessonService, lessonService);
// useContainer(Container);

// const app = createExpressServer({
//     controllers: [LessonController],
//     currentUserChecker: (action: Action) => action.request.user_id,
// });

const lessonController: LessonController = new LessonController(lessonService);

// describe('Lesson controller integration tests', () => {
//     beforeEach(() => {
//         reset(mockedLessonRepository);
//         reset(mockedSubjectRepository);
//         reset(mockedVirtualEntityRepository);
//     })

//     describe('Something', () => {
//         it('should work', async () => {
//             let r: CreateLessonRequest = {
//                 title: 'Lesson',
//                 description: 'Description',
//                 subjectId: 1,
//             }

//             let lesson: Lesson = new Lesson();
//             lesson.id = 1;

//             when(mockedLessonRepository.save(anything())).thenResolve(lesson);
//             when(mockedSubjectRepository.findOne(anything(), anything())).thenResolve(new Subject());

//             let response = await request(app)
//                 .post('/lesson/createLesson')
//                 .set('Authorization', validToken)
//                 .send(r);

//             console.log(response);

//             verify(mockedLessonRepository.save(anything())).once();
//             verify(mockedSubjectRepository.findOne(anything(), anything())).once();

//             expect(response.statusCode).toBe(200);
//             expect(response.body).toEqual({
//                 id: 1,
//             });

//             const [arg] = capture(mockedLessonRepository.save).last();
//             expect(arg).toBeInstanceOf(Lesson);
//         });
//     })
// })

describe("Lesson controller integration tests", () => {
	beforeEach(() => {
		reset(mockedLessonRepository);
		reset(mockedSubjectRepository);
		reset(mockedVirtualEntityRepository);
	});

	describe("Create Lesson", () => {
		it("successfully creates a lesson from the controller", async () => {
			const request: CreateLessonRequest = {
				title: "Lesson",
				description: "Description",
				subjectId: 1,
			};

			const lesson: Lesson = new Lesson();
			lesson.id = 1;

			when(mockedLessonRepository.save(anything())).thenResolve(lesson);
			when(
				mockedSubjectRepository.findOne(anything(), anything())
			).thenResolve(new Subject());

			const response = await lessonController.CreateLesson(request);
			verify(mockedLessonRepository.save(anything())).once();
			verify(
				mockedSubjectRepository.findOne(anything(), anything())
			).once();
			const [arg] = capture(mockedLessonRepository.save).last();
			expect(arg).toBeInstanceOf(Lesson);
			expect(response.id).toBe(1);
		});
	});

	describe("Get Lessons By Subject", () => {
		it("successfully gets lessons by subject", async () => {
			const request: GetLessonsBySubjectRequest = {
				subjectId: 1,
			};

			const lessons: Lesson[] = [
				new Lesson(),
				new Lesson(),
				new Lesson(),
			];

			const subject: Subject = new Subject();
			subject.id = 1;
			subject.lessons = lessons;

			when(
				mockedSubjectRepository.findOne(anything(), anything())
			).thenResolve(subject);

			const { data: response } =
				await lessonController.GetLessonsBySubject(request);
			verify(
				mockedSubjectRepository.findOne(anything(), anything())
			).once();
			expect(response.length).toBe(3);
		});

		it("throws an error when fetching from a subject that does not exist", async () => {
			const request: GetLessonsBySubjectRequest = {
				subjectId: 1,
			};

			when(
				mockedSubjectRepository.findOne(anything(), anything())
			).thenResolve(undefined);

			expect(() =>
				lessonController.GetLessonsBySubject(request)
			).rejects.toThrow(BadRequestError);
		});
	});

	describe("Add Virtual Entity To Lesson", () => {
		it("successfully adds a virtual entity to a lesson", async () => {
			const request: AddVirtualEntityToLessonRequest = {
				lessonId: 1,
				virtualEntityId: 1,
			};

			const virtualEntity: VirtualEntity = new VirtualEntity();
			virtualEntity.id = 1;

			const lesson: Lesson = new Lesson();
			lesson.id = 1;
			lesson.virtualEntities = [];

			when(
				mockedLessonRepository.findOne(anything(), anything())
			).thenResolve(lesson);
			when(mockedVirtualEntityRepository.findOne(anything())).thenResolve(
				virtualEntity
			);

			const response = await lessonController.AddVirtualEntityToLesson(
				request
			);
			verify(
				mockedLessonRepository.findOne(anything(), anything())
			).once();
			verify(mockedVirtualEntityRepository.findOne(anything())).once();
			expect(response).toBe("ok");
		});

		it("throws error when adding a virtual entity to a lesson that already has it", async () => {
			const request: AddVirtualEntityToLessonRequest = {
				lessonId: 1,
				virtualEntityId: 1,
			};

			const virtualEntity: VirtualEntity = new VirtualEntity();
			virtualEntity.id = 1;

			const lesson: Lesson = new Lesson();
			lesson.id = 1;
			lesson.virtualEntities = [virtualEntity];

			when(
				mockedLessonRepository.findOne(anything(), anything())
			).thenResolve(lesson);
			when(mockedVirtualEntityRepository.findOne(anything())).thenResolve(
				virtualEntity
			);

			expect(async () =>
				lessonController.AddVirtualEntityToLesson(request)
			).rejects.toThrow(BadRequestError);
		});
	});
});
