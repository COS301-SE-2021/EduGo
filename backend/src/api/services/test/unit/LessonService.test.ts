import 'reflect-metadata';
import { LessonService } from '../../lessonService';
import { Container, Service } from 'typedi';
import { Repository, EntityRepository, useContainer as orm_useContainer } from 'typeorm';
import * as mocks from "../RepositoryMocks";
import { Lesson } from '../../../database/Lesson';
import { Subject } from '../../../database/Subject';
import { VirtualEntity } from '../../../database/VirtualEntity';
import { CreateLessonRequest } from '../../../../api/models/lesson/CreateLessonRequest';

let subject: Subject = new Subject();
subject.lessons = [0, 1, 2, 3].map((value) => ({id: value, title: `Lesson ${value}`, description: 'Something', startTime: new Date(), endTime: new Date(), subject: subject, virtualEntities: []}));

const repositoryMock: () => mocks.MockType<Repository<any>> = jest.fn(() => ({
    save: jest.fn(entity => new Promise((res, rej) => res({id: 1, ...entity}))),
    findOne: jest.fn(() => new Promise((res, rej) => res(subject))),
}));


describe('Lesson Service', () => {
    let lessonService: LessonService = new LessonService(
        repositoryMock() as unknown as Repository<Lesson>,
        repositoryMock() as unknown as Repository<Subject>,
        repositoryMock() as unknown as Repository<VirtualEntity>
    );

    // service correctly creates a new lesson
    it('should create a new lesson', async () => {
        let request: CreateLessonRequest = {
            title: 'Test Lesson',
            description: 'Test Description',
            subjectId: 1,
        }

        let {id} = await lessonService.createLesson(request);
        console.log(`Id: ${id}`);
        expect(id).toBeDefined();
    });

    // test('subject has 4 lessons', async () => {
    //     let subjects = await lessonService.GetLessonsBySubject({subjectId: 1});
    //     expect(subjects.data.length).toBe(4);
    // });
});