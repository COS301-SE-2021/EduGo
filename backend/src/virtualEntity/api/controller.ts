import express from 'express';
import {createVirtualEntity} from '../service/service';
import {createVirtualEntityRequest} from '../model/apiModels'

const router = express.Router();

router.use((req, res, next) => {
    next()
})

router.post('/createVirtualEntity', async (req, res) => {
    let response = await createVirtualEntity(<createVirtualEntityRequest>req.body);
    if (response === undefined) {
        res.status(400);
        res.json({message: "Missing properties"})
        return;
    }
    res.status(200);
    res.json(response);
})

export {router}