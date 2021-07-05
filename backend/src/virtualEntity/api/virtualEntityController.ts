import express from 'express';
import {CreateVirtualEntityRequest} from '../model/CreateVirtualEntityRequest';
import { GetVirtualEntityRequest } from '../model/GetVirtualEntityRequest';
import { VirtualEntityService } from '../service/virtualEntityService';
import { VirtualEntityServiceImplementation } from '../service/virtualEntityServiceImplentation';
import { validateCreateVirtualEntityRequest, validateAddModelToVirtualEntityRequest, validateGetVirtualEntityRequest } from '../validate';
import { uploadFile } from '../../fileUpload';
import { AddModelToVirtualEntityFileData, AddModelToVirtualEntityRequest } from '../model/AddModelToVirtualEntityRequest';
import { AddModelToVirtualEntityResponse } from '../model/AddModelToVirtualEntityResponse';

const router = express.Router();
const service: VirtualEntityService = new VirtualEntityServiceImplementation();

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

router.post('/uploadModel', uploadFile.single('file'), async (req, res) => {
    const file: Express.MulterS3.File = <Express.MulterS3.File>req.file;

    if (file == undefined)
        res.status(400).json({message: 'Please upload a file'});

    let response: any = {
        file_name: file.key,
        file_size: file.size,
        file_type: file.key.split('.')[file.key.split('.').length-1],
        file_link: file.location
    }
    res.status(200).json(response);
})

router.post('addToVirtualEntity', uploadFile.single('file'), async (req, res) => {
    let valid = validateAddModelToVirtualEntityRequest(req.body);

    if (valid.ok) {
        const file: Express.MulterS3.File = <Express.MulterS3.File>req.file;
        let body: AddModelToVirtualEntityRequest = <AddModelToVirtualEntityRequest>req.body;
    
        if (file == undefined) {
            res.status(400).json({message: 'Please upload a file'});
            return;
        }
        
        let baseFile = {
            file_name: file.key,
            file_link: file.location,
            file_type: file.key.split('.')[file.key.split('.').length-1],
            file_size: file.size
        }
    
        let data: AddModelToVirtualEntityFileData = {
            id: body.virtualEntity_id,
            description: body.description,
            name: body.name,
            ...baseFile
        }

        service.AddModelToVirtualEntity(data).then(response => {
            let resp: AddModelToVirtualEntityResponse = {
                model_id: response.model_id,
                ...body,
                ...baseFile
            }
            res.status(200).json(resp)
        })
        return;
    }
    res.status(400).send(valid.message);
    
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
    let valid = validateGetVirtualEntityRequest(req.body);

    if (valid.ok) {
        let body = <GetVirtualEntityRequest>req.body;
        service.GetVirtualEntity(body).then(response => {
            res.status(200);
            res.json(response);
        })
        .catch(err => {
            res.status(400);
            res.json({message: 'error', error: err});
        })
    }
    else {
        res.status(400).send(valid.message)
    }
    
})

export {router}