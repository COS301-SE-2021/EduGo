import cors from 'cors';
import express from 'express';
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

app.get('/', (req, res) => {
    res.send('hey there')
})