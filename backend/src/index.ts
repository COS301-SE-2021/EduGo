import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import {Client} from 'pg';
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

import {router as LessonController} from './lesson/api/controller';
import {router as SubjectController} from './subject/api/controller';
import {router as VirtualEntityController} from './virtualEntity/api/controller';

const PORT = process.env.PORT || 8080;

export const app = express();
app.use(express.urlencoded({extended: true}));
app.use(express.json());
app.use(cors());
app.use('/lesson', LessonController)
app.use('/subject', SubjectController)
app.use('/virtualEntity', VirtualEntityController)

app.get('/', (req, res) => {
    res.send('hey there')
})

app.listen(PORT, () => console.log(`Server listening on port: ${PORT}`));