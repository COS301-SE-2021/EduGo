import express from 'express';
import {createLesson} from '../service/lessonService';
import { CreateLessonRequest } from '../models/CreateLessonRequest'

const router = express.Router();

router.use((req, res, next) => {
    next()
})

router.post('/createLesson', async (req, res) => {
    //Create lesson
    let response = await createLesson(<CreateLessonRequest>req.body);
    if (response === undefined) {
        res.status(400);
        res.json({message: "Missing properties"})
        return;
    }
    res.status(200);
    res.json(response);
})

export {router}