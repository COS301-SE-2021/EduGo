import express from "express";
import { upload, UploadModelToAzure } from "../helper/File";


const router = express.Router();

router.post('/uploadModel', upload, async (req, res) => {
    const file: Express.Multer.File = <Express.Multer.File>req.file;

    if (file == undefined)
        res.status(400).json({message: 'Please upload a file'});
    let result = await UploadModelToAzure(file);
    let response: any = {
        fileLink: result
    }
    res.status(200).json(response);
})

export {router};