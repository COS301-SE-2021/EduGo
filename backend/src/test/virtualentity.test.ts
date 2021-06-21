import { createConnection, getConnection } from "typeorm";

import {app} from '../index';
import request from 'supertest';
import { Lesson } from "../database/entity/Lesson";
import { Subject } from "../database/entity/Subject";

beforeAll(async () => {
    await createConnection({
        type: 'postgres',
        host: 'db',
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

    console.log("Connected: " + getConnection().isConnected)

    await getConnection().getRepository(Subject).save(sampleSubject);
})

describe('Testing if tests work', () => {
    test('Should pass', async () => {
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
        console.log(response.statusCode);
        expect(response.statusCode).toBe(200);
    })
})