import express from 'express';
import cors from 'cors';
import { createConnections, ConnectionOptions } from 'typeorm';

let options: ConnectionOptions[] = [
    {
        name: process.env.NODE_ENV === "test" ? "none" : "default",
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
    },
    {
        name: process.env.NODE_ENV === "test" ? "default" : "none",
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
    // {
    //     name: process.env.NODE_ENV === "test" ? "default" : "none",
    //     type: 'sqljs',
    //     database: new Uint8Array(),
    //     location: 'database',
    //     logging: false,
    //     synchronize: true,
    //     entities: ['src/database/entity/**/*.ts']
    // }
]


createConnections(options).then(conns => {
    if (conns[0].isConnected && conns[1].isConnected)
        console.log('Database connections established');
    else {
        console.log('There was an error connecting to the databases');
        throw new Error('Database connection error');
    }
})

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