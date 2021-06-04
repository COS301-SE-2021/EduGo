import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import http from 'http';
import {Client} from 'pg';

dotenv.config();

const client = new Client({
    user: process.env.DB_USER,
    host: process.env.DB_URL,
    database: 'edugo',
    password: process.env.DB_PASS,
    port: 5432
});

client.connect();

export {client};

import {router as LessonController} from './lesson/api/controller';
import {router as SubjectController} from './lesson/api/controller';
import {router as VirtualEntityController} from './lesson/api/controller';

const PORT = process.env.PORT || 8080;

export const app = express();
app.use(express.urlencoded({extended: true}));
app.use(express.json());
app.use(cors());
app.use('/lesson', LessonController)
app.use('/subject', SubjectController)
app.use('/virtualEntity', VirtualEntityController)

const server = http.createServer(app);
server.listen(PORT);