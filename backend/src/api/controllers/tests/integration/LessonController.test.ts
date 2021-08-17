import 'reflect-metadata';
import { Lesson } from '../../../../api/database/Lesson';
import { Subject } from '../../../../api/database/Subject';
import { VirtualEntity } from '../../../../api/database/VirtualEntity';
import { mock, instance, when, verify, anything } from 'ts-mockito';
import { Repository } from 'typeorm';
import { LessonService } from '../../../../api/services/LessonService';
import { LessonController } from '../../lessonController';
import { CreateLessonRequest } from '../../../../api/models/lesson/CreateLessonRequest';

let mockedLessonRepository: Repository<Lesson> = mock(Repository);
let lessonRepository: Repository<Lesson> = instance(mockedLessonRepository);

let mockedSubjectRepository: Repository<Subject> = mock(Repository);
let subjectRepository: Repository<Subject> = instance(mockedSubjectRepository);

let mockedVirtualEntityRepository: Repository<VirtualEntity> = mock(Repository);
let virtualEntityRepository: Repository<VirtualEntity> = instance(mockedVirtualEntityRepository);

let lessonService: LessonService = new LessonService(lessonRepository, subjectRepository, virtualEntityRepository);

let lessonController: LessonController = new LessonController(lessonService);

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
        expect(response.id).toBe(1);
    });
})