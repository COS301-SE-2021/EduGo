import express from 'express';
import {createQuestion} from '../service/service';
import {createQuestionRequest} from '../model/apiModels'

const router = express.Router();

router.use((req, res, next) => {
    next()
})

router.post('/createQuestion', async (req, res) => {
    let response = await createQuestion(<createQuestionRequest>req.body);
    if (response === undefined) {
        res.status(400);
        res.json({message: "Missing properties"})
        return;
    }
    res.status(200);
    res.json(response);
})

export {router}