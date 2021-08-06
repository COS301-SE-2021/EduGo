import 'reflect-metadata';
import { LessonService } from '../lessonService';
import { Container } from 'typedi';
import { Repository, EntityRepository } from 'typeorm';
import { Lesson } from '../../../api/database/Lesson';

@EntityRepository(Lesson)
export class LessonRepository extends Repository<Lesson> {

}

describe('Lesson Service', () => {
    let lessonService: LessonService = Container.get(LessonService);

});