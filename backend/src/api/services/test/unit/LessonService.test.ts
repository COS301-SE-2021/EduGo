import 'reflect-metadata';
import { LessonService } from '../../LessonService';
import { Repository } from 'typeorm';
import * as mocks from "../RepositoryMocks";
import { Lesson } from '../../../database/Lesson';
import { Subject } from '../../../database/Subject';
import { VirtualEntity } from '../../../database/VirtualEntity';
import { CreateLessonRequest } from '../../../../api/models/lesson/CreateLessonRequest';
import { BadRequestError } from 'routing-controllers';
import { mock, instance, when, anyOfClass, anyNumber, anything, verify } from 'ts-mockito';

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
    })
});