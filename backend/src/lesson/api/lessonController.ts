import express from 'express';
import {createLesson, GetLessonsBySubject} from '../service/lessonService';
import { CreateLessonRequest } from '../models/CreateLessonRequest'
import { GetLessonsBySubjectRequest } from '../models/GetLessonsBySubjectRequest';

const router = express.Router();

router.use((req, res, next) => {
    next()
})

router.post('/createLesson', async (req, res) => {
    //Create lesson
    let response = await createLesson(<CreateLessonRequest>req.body);
    res.status(200);
    res.json(response);
})

router.get("/getLessonsBySubject", async (req, res) => {
    //Create lesson
    let response = await GetLessonsBySubject(<GetLessonsBySubjectRequest>req.body);
    res.status(200);
    res.json(response);
})

export {router}