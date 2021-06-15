import express from 'express';
import {CreateVirtualEntityRequest} from '../model/CreateVirtualEntityRequest';
import { VirtualEntityService } from '../service/virtualEntityService';
import { VirtualEntityServiceImplementation } from '../service/virtualEntityServiceImplentation';

const router = express.Router();
const service: VirtualEntityService = new VirtualEntityServiceImplementation();

router.post('/createVirtualEntity', async (req, res) => {
    let body = <CreateVirtualEntityRequest>req.body;
    service.CreateVirtualEntity(body).then(response => {
        res.status(200);
        res.json(response);
    })
    .catch(err => {
        res.status(400);
        res.json({message: 'error', error: err});
    })
})

export {router}