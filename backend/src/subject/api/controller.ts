import express from 'express';
import { createSubjectRequest } from '../model/apiModels';
import { createSubject } from '../service/service';

const router = express.Router();

router.use((req, res, next) => {
    next()
})

router.post('/createSubject', async (req, res) => {
    let response = await createSubject(<createSubjectRequest>req.body);
    if (response === undefined) {
        res.status(400);
        res.json({message: "Missing properties"})
        return;
    }
    res.status(200);
    res.json(response);
})

export {router}