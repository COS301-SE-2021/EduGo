import express from 'express';
import {CreateVirtualEntityRequest} from '../model/CreateVirtualEntityRequest';
import { GetVirtualEntitiesRequest } from '../model/GetVirtualEntitiesRequest';
import { GetVirtualEntityRequest } from '../model/GetVirtualEntityRequest';
import { VirtualEntityService } from '../service/virtualEntityService';
import { VirtualEntityServiceImplementation } from '../service/virtualEntityServiceImplentation';
import {router as modelController} from './modelController';
import { validateCreateVirtualEntityRequest } from '../validate';
const router = express.Router();
const service: VirtualEntityService = new VirtualEntityServiceImplementation();
router.use('/model', modelController);

router.post('/createVirtualEntity', async (req, res) => {
    let valid = validateCreateVirtualEntityRequest(req.body);
    if (valid.ok) {
        let body = <CreateVirtualEntityRequest>req.body;
        service.CreateVirtualEntity(body).then(response => {
            res.status(200);
            res.json(response);
        })
        .catch(err => {
            res.status(400);
            res.json({message: 'error', error: err});
        })
    }
    else {
        res.status(400);
        res.json(valid);
    }
    
})

router.post('/getVirtualEntities', async (req, res) => {
    service.GetVirtualEntities({}).then(response => {
        res.status(200);
        res.json(response);
    })
    .catch(err => {
        res.status(400);
        res.json({message: 'error', error: err})
    })
})

router.post('/getVirtualEntity', async (req, res) => {
    let body = <GetVirtualEntityRequest>req.body;
    service.GetVirtualEntity(body).then(response => {
        res.status(200);
        res.json(response);
    })
    .catch(err => {
        res.status(400);
        res.json({message: 'error', error: err});
    })
})

export {router}