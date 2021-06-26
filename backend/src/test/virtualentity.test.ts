import { createConnection, getConnection } from "typeorm";

import {app} from '../index';
import request from 'supertest';
import { Lesson } from "../database/entity/Lesson";
import { Subject } from "../database/entity/Subject";
import { validateCreateVirtualEntityRequest } from '../virtualEntity/validate';

beforeAll(async () => {
    await createConnection({
        type: 'postgres',
        host: process.env.DB_HOST || 'localhost',
        port: 5432,
        username: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: 'test',
        synchronize: true,
        logging: false,
        entities: ['src/database/entity/**/*.ts'],
        migrations: ['src/database/migration/**/*.ts'],
        subscribers: ['src/database/subscriber/**/*.ts'],
        cli: {
            entitiesDir: 'src/database/entity',
            migrationsDir: 'src/database/migration',
            subscribersDir: 'src/database/subscriber'
        }
    });

    let sampleLesson: Lesson = new Lesson();
    sampleLesson.title = 'Test Lesson';
    sampleLesson.description = 'Just a test';
    sampleLesson.date = '21/06/2021';

    let sampleSubject: Subject = new Subject();
    sampleSubject.title = 'Test Subject';
    sampleSubject.description = 'Just a test';
    sampleSubject.educatorId = 1;
    sampleSubject.grade = 12;
    sampleSubject.lessons = [sampleLesson];

    await getConnection().getRepository(Subject).save(sampleSubject);
})

afterAll(async () => {
    await getConnection().close();
    console.log('closed');
})

describe('Create Virtual Entity', () => {
    test('If basic create virtual entity validation passes', () => {
        let data = {
            lesson_id: 1,
            title: '',
            description: ''
        }

        let result = validateCreateVirtualEntityRequest(data);
        expect(result.ok).toBe(true);
    });

    test('If incorrect basic create virtual entity validation passes', () => {
        let data = {
            lesson_id: 1,
            title: '',
        }

        let result = validateCreateVirtualEntityRequest(data);
        expect(result.ok).toBe(false);
        expect(result.message).toContain('description');
    });

    test('If create virtual entity validation with model passes', () => {
        let data = {
            lesson_id: 1,
            title: '',
            description: '',
            model: {
                name: '',
                file_link: '',
                file_size: 0,
                file_name: '',
                file_type: ''
            }
        }

        let result = validateCreateVirtualEntityRequest(data);
        expect(result.ok).toBe(true);
    })

    test('If create virtual entity validation with model passes', () => {
        let data = {
            lesson_id: 1,
            title: '',
            description: '',
            model: {
                name: '',
                file_link: '',
                file_name: '',
                file_type: ''
            }
        }

        let result = validateCreateVirtualEntityRequest(data);
        expect(result.ok).toBe(false);
        expect(result.message).toContain('file_size');
    })

    test('If create virtual entity validation with quiz and no questions passes', () => {
        let data = {
            lesson_id: 1,
            title: '',
            description: '',
            quiz: {
                title: '',
                description: ''
            }
        }

        let result = validateCreateVirtualEntityRequest(data);
        expect(result.ok).toBe(true);
    });

    test('If create virtual entity validation with quiz and no questions passes', () => {
        let data = {
            lesson_id: 1,
            title: '',
            description: '',
            quiz: {
                description: ''
            }
        }

        let result = validateCreateVirtualEntityRequest(data);
        expect(result.ok).toBe(false);
        expect(result.message).toContain('title');
    });

    test('If create virtual entity validation with quiz and a question passes', () => {
        let data = {
            lesson_id: 1,
            title: '',
            description: '',
            quiz: {
                title: '',
                description: '',
                questions: [
                    {
                        type: '',
                        question: ''
                    }
                ]
            }
        }

        let result = validateCreateVirtualEntityRequest(data);
        expect(result.ok).toBe(true);
    })

    test('If create virtual entity validation with quiz and a question passes', () => {
        let data = {
            lesson_id: 1,
            title: '',
            description: '',
            quiz: {
                title: '',
                description: '',
                questions: [
                    {
                        question: ''
                    }
                ]
            }
        }

        let result = validateCreateVirtualEntityRequest(data);
        expect(result.ok).toBe(false);
        expect(result.message).toContain('type');
    })

    test('If new virtual entity is successfully created', async () => {
        const response = await request(app).post('/virtualEntity/createVirtualEntity').send({
            lesson_id: 1,
            title: "Virtual Entity",
            description: "The first actual virtual entity",
            quiz: {
                title: "The quiz",
                description: "Info about the quiz",
                questions: [
                    {
                        type: "TrueFalse",
                        question: "What is the answer",
                        options: ["True", "False"],
                        correctAnswer: "True"
                    },
                    {
                        type: "MultipleChoice",
                        question: "What is the second answer",
                        options: ["A", "B", "C", "D"],
                        correctAnswer: "B"
                    }
                ]
            },
            model: {
                name: "A New Model",
                description: "Info about the model",
                file_link: "http://model",
                file_size: 36.2,
                file_type: "obj",
                file_name: "model_1",
                preview_img: ""
            }
        })
        expect(response.statusCode).toBe(200);
    })

    test('If new virtual entity is not successfully created due to invalid request body', async () => {
        const response = await request(app).post('/virtualEntity/createVirtualEntity').send({
            lesson_id: 1,
            title: "Virtual Entity",
            description: "The first actual virtual entity",
            quiz: {
                title: "The quiz",
                description: "Info about the quiz",
                questions: [
                    {
                        question: "What is the answer",
                        options: ["True", "False"],
                        correctAnswer: "True"
                    },
                    {
                        type: "MultipleChoice",
                        question: "What is the second answer",
                        options: ["A", "B", "C", "D"],
                        correctAnswer: "B"
                    }
                ]
            },
            model: {
                name: "A New Model",
                description: "Info about the model",
                file_link: "http://model",
                file_size: 36.2,
                file_type: "obj",
                file_name: "model_1",
                preview_img: ""
            }
        })
        expect(response.statusCode).toBe(400);
        expect(response.body.message).toContain('type');
    })
})