import express from 'express';
import multer from 'multer';
import multerS3 from 'multer-s3';
import AWS from 'aws-sdk';
import dotenv from 'dotenv';

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

router.post('/uploadModel', uploadToS3.single('file'), async (req, res) => {
    const file: Express.MulterS3.File = <Express.MulterS3.File>req.file;

    if (file == undefined) {
        res.status(400);
        res.json({message: 'Please upload a file'});
    }

    let response: any = {
        file: {
            original_file_name: file.originalname,
            new_file_name: file.key,
            file_size: file.size,
            file_type: file.key.split('.')[file.key.split('.').length-1],
            file_link: file.location
        }
    }
    res.status(200);
    res.json(response);
})

export {router};