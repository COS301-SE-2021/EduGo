import express from "express";
import { uploadFile } from "../helper/aws/fileUpload";


const router = express.Router();

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

export {router};