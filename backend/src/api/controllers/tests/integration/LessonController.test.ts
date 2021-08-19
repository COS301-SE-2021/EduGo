import 'reflect-metadata';
import { Lesson } from '../../../database/Lesson';
import { Subject } from '../../../database/Subject';
import { VirtualEntity } from '../../..//database/VirtualEntity';
import { mock, instance, when, verify, anything, reset, capture } from 'ts-mockito';
import { Repository } from 'typeorm';
import { LessonService } from '../../../services/LessonService';
import { LessonController } from '../../lessonController';
import { CreateLessonRequest } from '../../../models/lesson/CreateLessonRequest';
import { GetLessonsBySubjectRequest } from '../../../models/lesson/GetLessonsBySubjectRequest'
import { AddVirtualEntityToLessonRequest } from '../../../models/lesson/AddVirtualEntityToLessonRequest';
import { Action, BadRequestError, createExpressServer, useContainer } from 'routing-controllers';
import { Container } from "typedi";
import request from "supertest";
import { User } from '../../../database/User';
import { issueJWT } from '../../../helper/auth/utils';

let mockedLessonRepository: Repository<Lesson> = mock(Repository);
let lessonRepository: Repository<Lesson> = instance(mockedLessonRepository);

let mockedSubjectRepository: Repository<Subject> = mock(Repository);
let subjectRepository: Repository<Subject> = instance(mockedSubjectRepository);

let mockedVirtualEntityRepository: Repository<VirtualEntity> = mock(Repository);
let virtualEntityRepository: Repository<VirtualEntity> = instance(mockedVirtualEntityRepository);

let lessonService: LessonService = new LessonService(lessonRepository, subjectRepository, virtualEntityRepository);

let validUser: User = new User();
validUser.id = 1;

let {token: validToken} = issueJWT(validUser);

Container.set(LessonService, lessonService);
useContainer(Container);

const app = createExpressServer({
    controllers: [LessonController],
    currentUserChecker: (action: Action) => action.request.user_id,
});

let lessonController: LessonController = new LessonController(lessonService);

describe('Lesson controller integration tests', () => {
    beforeEach(() => {
        reset(mockedLessonRepository);
        reset(mockedSubjectRepository);
        reset(mockedVirtualEntityRepository);
    })

    describe('Something', () => {
        it('should work', async () => {
            let r: CreateLessonRequest = {
                title: 'Lesson',
                description: 'Description',
                subjectId: 1,
            }

            let lesson: Lesson = new Lesson();
            lesson.id = 1;

            when(mockedLessonRepository.save(anything())).thenResolve(lesson);
            when(mockedSubjectRepository.findOne(anything(), anything())).thenResolve(new Subject());

            let response = await request(app)
                .post('/lesson/createLesson')
                .set('Authorization', validToken)
                .send(r);

            console.log(response);
            
            verify(mockedLessonRepository.save(anything())).once();
            verify(mockedSubjectRepository.findOne(anything(), anything())).once();

            expect(response.statusCode).toBe(200);
            expect(response.body).toEqual({
                id: 1,
            });

            const [arg] = capture(mockedLessonRepository.save).last();
            expect(arg).toBeInstanceOf(Lesson);
        });
    })
})

describe.skip('Lesson controller integration tests', () => {
    beforeEach(() => {
        reset(mockedLessonRepository);
        reset(mockedSubjectRepository);
        reset(mockedVirtualEntityRepository);
    })

    describe('Create Lesson', () => {
        it('successfully creates a lesson from the controller', async () => {
            let request: CreateLessonRequest = {
                title: 'Lesson',
                description: 'Description',
                subjectId: 1,
            }

            let lesson: Lesson = new Lesson();
            lesson.id = 1;

            when(mockedLessonRepository.save(anything())).thenResolve(lesson);
            when(mockedSubjectRepository.findOne(anything(), anything())).thenResolve(new Subject());

            let response = await lessonController.CreateLesson(request);
            verify(mockedLessonRepository.save(anything())).once();
            verify(mockedSubjectRepository.findOne(anything(), anything())).once();
            const [arg] = capture(mockedLessonRepository.save).last();
            expect(arg).toBeInstanceOf(Lesson);
            expect(response.id).toBe(1);
        });
    })

    describe('Get Lessons By Subject', () => {
        it('successfully gets lessons by subject', async () => {
            let request: GetLessonsBySubjectRequest = {
                subjectId: 1,
            }

            let lessons: Lesson[] = [
                new Lesson(),
                new Lesson(),
                new Lesson(),
            ];

            let subject: Subject = new Subject();
            subject.id = 1;
            subject.lessons = lessons;

            when(mockedSubjectRepository.findOne(anything(), anything())).thenResolve(subject);

            let {data: response} = await lessonController.GetLessonsBySubject(request);
            verify(mockedSubjectRepository.findOne(anything(), anything())).once();
            expect(response.length).toBe(3);
        });

        it('throws an error when fetching from a subject that does not exist', async () => {
            let request: GetLessonsBySubjectRequest = {
                subjectId: 1,
            }

            when(mockedSubjectRepository.findOne(anything(), anything())).thenResolve(undefined);

            expect(() => lessonController.GetLessonsBySubject(request)).rejects.toThrow(BadRequestError);
        })
    });

    describe('Add Virtual Entity To Lesson', () => {
        it('successfully adds a virtual entity to a lesson', async () => {
            let request: AddVirtualEntityToLessonRequest = {
                lessonId: 1,
                virtualEntityId: 1,
            }
            
            let virtualEntity: VirtualEntity = new VirtualEntity();
            virtualEntity.id = 1;

            let lesson: Lesson = new Lesson();
            lesson.id = 1;
            lesson.virtualEntities = [];

            when(mockedLessonRepository.findOne(anything(), anything())).thenResolve(lesson);
            when(mockedVirtualEntityRepository.findOne(anything())).thenResolve(virtualEntity);

            let response = await lessonController.AddVirtualEntityToLesson(request);
            verify(mockedLessonRepository.findOne(anything(), anything())).once();
            verify(mockedVirtualEntityRepository.findOne(anything())).once();
            expect(response).toBe('ok');
        });

        it('throws error when adding a virtual entity to a lesson that already has it', async () => {
            let request: AddVirtualEntityToLessonRequest = {
                lessonId: 1,
                virtualEntityId: 1,
            }
            
            let virtualEntity: VirtualEntity = new VirtualEntity();
            virtualEntity.id = 1;

            let lesson: Lesson = new Lesson();
            lesson.id = 1;
            lesson.virtualEntities = [virtualEntity];

            when(mockedLessonRepository.findOne(anything(), anything())).thenResolve(lesson);
            when(mockedVirtualEntityRepository.findOne(anything())).thenResolve(virtualEntity);

            expect(async () => lessonController.AddVirtualEntityToLesson(request)).rejects.toThrow(BadRequestError);
        });
    });
});