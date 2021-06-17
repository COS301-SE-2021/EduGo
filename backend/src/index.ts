import express from 'express';
import cors from 'cors';
import { dbInit } from './database/index';

//dotenv.config();

// const client = new Client({
//     user: process.env.DB_USER,
//     host: 'db',
//     database: 'edugo',
//     password: process.env.DB_PASSWORD,
//     port: 5432
// });

// client.connect();

// export {client};

dbInit();


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