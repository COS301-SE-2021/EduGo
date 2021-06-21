import express from 'express';
import cors from 'cors';
import { createConnection, ConnectionOptions } from 'typeorm';

let options: ConnectionOptions = {
    type: 'postgres',
    host: 'db',
    port: 5432,
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: 'edugo',
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
}

if (process.env.NODE_ENV === 'test') {
    options = {
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
    }
}

if (process.env.NODE_ENV !== 'test') {
    createConnection(options).then(conn => {
        if (conn.isConnected) {
            console.log('Database connection established');
        }
        else {
            throw new Error('Database connection failed')
        }
    })
}

import {router as LessonController} from './lesson/api/lessonController';
import {router as SubjectController} from './subject/api/subjectController';
import {router as VirtualEntityController} from './virtualEntity/api/virtualEntityController';

const PORT = process.env.PORT || 8080;

export const app = express();
app.use(express.urlencoded({extended: true}));
app.use(express.json());
app.use(cors());
app.use('/lesson', LessonController)
app.use('/subject', SubjectController)
app.use('/virtualEntity', VirtualEntityController)

/*
 * Look, it's a comment
 * TODO Fix this
 */

// app.use((req, res, next) => {
//     express.json()(req, res, err => {
//         if (err) {
//             if (err instanceof SyntaxError) {

//             }
//         }
//     })
// })

app.get('/', (req, res) => {
    res.send('hey there')
})

app.listen(PORT, () => console.log(`Server listening on port: ${PORT}`));