import express from 'express';
import multer from 'multer';
import multerS3 from 'multer-s3';
import AWS from 'aws-sdk';
import dotenv from 'dotenv';
import { AddModelToVirtualEntityFileData, AddModelToVirtualEntityRequest } from '../model/AddModelToVirtualEntityRequest';
import { AddModelToVirtualEntityResponse } from '../model/AddModelToVirtualEntityResponse';
import { VirtualEntityService } from '../service/virtualEntityService';
import { VirtualEntityServiceImplementation } from '../service/virtualEntityServiceImplentation';

dotenv.config();
const router = express.Router();

AWS.config.update({
    accessKeyId: process.env.AWS_ACCESS_KEY,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
    region: 'af-south-1'
})

const s3 = new AWS.S3();

const uploadToS3 = multer({
    storage: multerS3({
        s3: s3,
        acl: 'public-read',
        bucket: 'edugo',
        metadata: (req, file, cb) => {
            cb(null, {fieldName: file.fieldname})
        },
        key: (req, file, cb) => {
            cb(null, `${Date.now().toString()}-${file.originalname}`)
        }
    })
});

const service: VirtualEntityService = new VirtualEntityServiceImplementation();

router.post('/uploadModel', uploadToS3.single('file'), async (req, res) => {
    const file: Express.MulterS3.File = <Express.MulterS3.File>req.file;

    if (file == undefined) {
        res.status(400);
        res.json({message: 'Please upload a file'});
    }

    let response: any = {
        file_name: file.key,
        file_size: file.size,
        file_type: file.key.split('.')[file.key.split('.').length-1],
        file_link: file.location
    }
    res.status(200);
    res.json(response);
})

router.post('/addToVirtualEntity', uploadToS3.single('file'), async (req, res) => {
    const file: Express.MulterS3.File = <Express.MulterS3.File>req.file;
    let body: AddModelToVirtualEntityRequest = <AddModelToVirtualEntityRequest>req.body;
    if (file == undefined) {
        res.status(400);
        res.json({message: 'Please upload a file'});
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
        res.status(200);
        res.json(resp)
    })
})

export {router};