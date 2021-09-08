import 'reflect-metadata';
import { LessonService } from '../../LessonService';
import { Repository } from 'typeorm';
import { Lesson } from '../../../database/Lesson';
import { Subject } from '../../../database/Subject';
import { VirtualEntity } from '../../../database/VirtualEntity';
import { CreateLessonRequest } from '../../../../api/models/lesson/CreateLessonRequest';
import { BadRequestError } from 'routing-controllers';
import { mock, instance, when, anyOfClass, anyNumber, anything, verify, capture, reset } from 'ts-mockito';
import { GetLessonsBySubjectRequest } from '../../../../api/models/lesson/GetLessonsBySubjectRequest';
import { AddVirtualEntityToLessonRequest } from '../../../../api/models/lesson/AddVirtualEntityToLessonRequest';

let subject: Subject = new Subject();
subject.lessons = [0, 1, 2, 3].map((value) => ({id: value, grades: [], title: `Lesson ${value}`, description: 'Something', startTime: new Date(), endTime: new Date(), subject: subject, virtualEntities: []}));

let mockedLessonRepository: Repository<Lesson> = mock(Repository);
let lessonRepository: Repository<Lesson> = instance(mockedLessonRepository);

let mockedSubjectRepository: Repository<Subject> = mock(Repository);
let subjectRepository: Repository<Subject> = instance(mockedSubjectRepository);

let mockedVirtualEntityRepository: Repository<VirtualEntity> = mock(Repository);
let virtualEntityRepository: Repository<VirtualEntity> = instance(mockedVirtualEntityRepository);

let lessonService: LessonService = new LessonService(
    lessonRepository,
    subjectRepository,
    virtualEntityRepository
);  

describe('Lesson', () => {
    beforeEach(() => {
        reset(mockedLessonRepository);
        reset(mockedSubjectRepository);
        reset(mockedVirtualEntityRepository);
    });

    describe('Create Lesson', () => {

        it('should create a new lesson', async () => {
            let request: CreateLessonRequest = {
                title: 'Test Lesson',
                description: 'Test Description',
                subjectId: 1,
            }

            when(mockedSubjectRepository.findOne(anyNumber(), anything())).thenResolve(subject);
            when(mockedLessonRepository.save(anyOfClass(Lesson))).thenResolve({id: 1})

            
            let {id} = await lessonService.CreateLesson(request);
            verify(mockedLessonRepository.save(anyOfClass(Lesson))).once();

            expect(id).toBeDefined();
            expect(id).toBe(1);
        });

        it('should throw BadRequestError when an undefined subject is returned', async () => {
            let request: CreateLessonRequest = {
                title: 'Test Lesson',
                description: 'Test Description',
                subjectId: 0,
            }

            when(mockedSubjectRepository.findOne(anyNumber(), anything())).thenResolve(undefined);
            when(mockedLessonRepository.save(anyOfClass(Lesson))).thenReject(new BadRequestError('Subject not found'));

            expect(async () => await lessonService.CreateLesson(request)).rejects.toThrow(BadRequestError);
        });
    });

    describe('Get Lessons By Subject', () => {
        it('should get all the lessons belonging to a subject', async () => {
            let request: GetLessonsBySubjectRequest = {
                subjectId: 1
            }

            when(mockedSubjectRepository.findOne(anyNumber(), anything())).thenResolve(subject);

            let {data} = await lessonService.GetLessonsBySubject(request);

            verify(mockedSubjectRepository.findOne(anyNumber(), anything())).once();

            expect(data).toBeDefined();
            expect(data.length).toBe(4);
            expect(data[0].id).toBe(0);
            expect(data[0].title).toBe('Lesson 0');
        });

        it('should throw BadRequestError when an undefined subject is returned', async () => {
            let request: GetLessonsBySubjectRequest = {
                subjectId: 0
            }

            when(mockedSubjectRepository.findOne(anyNumber(), anything())).thenResolve(undefined);

            expect(async () => await lessonService.GetLessonsBySubject(request)).rejects.toThrow(BadRequestError);
        });

    });

    describe('Add Virtual Entity To Lesson', () => {
        it('should add a virtual entity to lesson', async () => {
            let request: AddVirtualEntityToLessonRequest = {
                lessonId: 1,    
                virtualEntityId: 1
            }

            let virtualEntity: VirtualEntity = new VirtualEntity();
            virtualEntity.id = 1;
            virtualEntity.title = 'Test Virtual Entity';
            virtualEntity.description = 'Test Description';
            virtualEntity.public = true;

            when(mockedLessonRepository.findOne(anyNumber(), anything())).thenResolve(subject.lessons[0]);
            when(mockedVirtualEntityRepository.findOne(anyNumber())).thenResolve(virtualEntity);

            await lessonService.AddVirtualEntityToLesson(request);
            verify(mockedLessonRepository.findOne(anyNumber(), anything())).once();
            verify(mockedVirtualEntityRepository.findOne(anyNumber())).once();
            verify(mockedLessonRepository.save(anything())).once();

            const [arg] = capture(mockedLessonRepository.save).last();
            expect(arg.virtualEntities?.length).toBe(1);
            expect(arg.virtualEntities?.pop()?.id).toBe(1);
        });

        it('should throw BadRequestError when an undefined lesson is returned', async () => {
            let request: AddVirtualEntityToLessonRequest = {
                lessonId: 0,    
                virtualEntityId: 1
            }

            when(mockedLessonRepository.findOne(anyNumber(), anything())).thenResolve(undefined);

            expect(async () => await lessonService.AddVirtualEntityToLesson(request)).rejects.toThrow(BadRequestError);
        });

        it('should throw BadRequestError when virtual entity already exists in lesson', async () => {
            let request: AddVirtualEntityToLessonRequest = {
                lessonId: 1,    
                virtualEntityId: 1
            }

            let virtualEntity: VirtualEntity = new VirtualEntity();
            virtualEntity.id = 1;
            virtualEntity.title = 'Test Virtual Entity';
            virtualEntity.description = 'Test Description';
            virtualEntity.public = true;

            subject.lessons[0].virtualEntities.push(virtualEntity);

            when(mockedLessonRepository.findOne(anyNumber(), anything())).thenResolve(subject.lessons[0]);
            when(mockedVirtualEntityRepository.findOne(anyNumber())).thenResolve(virtualEntity);

            expect(async () => await lessonService.AddVirtualEntityToLesson(request)).rejects.toThrow(BadRequestError);
        });
    });
});