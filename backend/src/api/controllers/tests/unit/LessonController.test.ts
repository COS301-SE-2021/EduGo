import 'reflect-metadata';
import {LessonController} from "../../lessonController";
import { mock, when, instance, anyOfClass, verify, reset, anything } from "ts-mockito";
import { LessonService } from '../../../services/LessonService';
import { CreateLessonRequest } from '../../../models/lesson/CreateLessonRequest';
import { GetLessonsBySubjectRequest } from '../../../models/lesson/GetLessonsBySubjectRequest';
import { AddVirtualEntityToLessonRequest } from '../../../models/lesson/AddVirtualEntityToLessonRequest';

let mockedService: LessonService = mock(LessonService);
let service: LessonService = instance(mockedService);
let controller: LessonController = new LessonController(service);

describe('Create Lesson', () => {
    beforeEach(() => {
        reset(mockedService);
    });

    it('should veirfy that the create lesson function was called from the service', () => {
        let lesson: CreateLessonRequest = {
            title: 'Test Lesson',
            description: 'Test Description',
            subjectId: 1
        };

        when(mockedService.CreateLesson(lesson)).thenResolve({id: 1});
        let result = controller.CreateLesson(lesson)

        verify(mockedService.CreateLesson(anything())).once();
    });
});

describe('Get lessons by subject', () => {
    beforeEach(() => {
        reset(mockedService);
    });

    it('should verify that the get lessons by subject function was called from the service', () => {
        let request: GetLessonsBySubjectRequest = {
            subjectId: 1
        }
        let subjectId: number = 1;

        when(mockedService.GetLessonsBySubject(request)).thenResolve({data: [], statusMessage: ''});
        let result = controller.GetLessonsBySubject(request);

        verify(mockedService.GetLessonsBySubject(anything())).once();
    });
})

describe('Add virtual entity to lesson', () => {
    beforeEach(() => {
        reset(mockedService);
    });

    it('should verify that the add virtual entity function was called from the service', () => {
        let request: AddVirtualEntityToLessonRequest = {
            virtualEntityId: 1,
            lessonId: 1
        };

        when(mockedService.AddVirtualEntityToLesson(request)).thenResolve("");
        let result = controller.AddVirtualEntityToLesson(request);

        verify(mockedService.AddVirtualEntityToLesson(anything())).once();
    });
})