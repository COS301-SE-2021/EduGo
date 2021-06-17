import express from 'express';
import { GetLessonsBySubjectRequest } from '../../lesson/models/GetLessonsBySubjectRequest';
import { GetSubjectsByEducator } from '../../subject/service/subjectService';
import { createSubjectRequest } from '../model/apiModels';
import { CreateSubjectRequest } from '../model/CreateSubjectRequest';
import { GetSubjectsByEducatorRequest } from '../model/GetSubjectsByEducatorRequest';
import { createSubject } from '../service/subjectService';

const router = express.Router();

router.use((req, res, next) => {
    next()
})

router.post('/createSubject', async (req, res) => {
    //Create subject
    let response = await createSubject(<CreateSubjectRequest>req.body);
    res.status(200);
    res.json(response);
})

router.get("/getSubjectsByLecturer", async (req, res) => {
    //Create lesson
    let response = await GetSubjectsByEducator(<GetSubjectsByEducatorRequest>req.body);
    res.status(200);
    res.json(response);
})

export {router}