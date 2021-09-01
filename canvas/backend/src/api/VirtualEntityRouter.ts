import express from 'express';
import { plainToClass } from 'class-transformer';
import { validate } from 'class-validator';
import { GetVirtualEntityRequest } from './GetVirtualEntityRequest';
import axios from 'axios';

const router = express.Router();

router.post('/getVirtualEntity', async (req, res) => {
    const request: GetVirtualEntityRequest = plainToClass(GetVirtualEntityRequest, req.body);
    let valid = await validate(request);
    if (valid.length > 0) {res.status(400).send(valid); return;}
    if (!req.headers.authorization || req.headers.authorization.split(' ')[0] !== 'Bearer') {res.sendStatus(401); return;}

    let virtualEntityId: number = request.virtualEntityId;
    let response = await axios.post(
        `${process.env.MAIN_BACKEND_URL}/virtualEntity/getVirtualEntity`, 
        { id: virtualEntityId }, 
        { headers: {authorization: req.headers.authorization} }
    );
    if (response.status === 200) {
        res.send(response.data);
        return;
    }

    res.sendStatus(response.status);
});

export { router };