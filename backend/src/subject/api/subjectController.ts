import express from "express";
import { uploadFile } from "../../fileUpload";
import { GetLessonsBySubjectRequest } from "../../lesson/models/GetLessonsBySubjectRequest";
import { GetSubjectsByEducator } from "../../subject/service/subjectService";
import { CreateSubjectRequest } from "../model/CreateSubjectRequest";
import { GetSubjectsByEducatorRequest } from "../model/GetSubjectsByEducatorRequest";
import { createSubject } from "../service/subjectService";

const router = express.Router();

router.use((req, res, next) => {
  next();
});

router.post("/createSubject", uploadFile.single('file'), async (req, res) => {
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
  
  
  //Create subject
  createSubject(<CreateSubjectRequest>req.body).then((subjectResponse) => {
    res.status(200);
    res.json(subjectResponse);
  });
});

router.post("/getSubjectsByEducator", async (req, res) => {
  //Create lesson
  GetSubjectsByEducator(<GetSubjectsByEducatorRequest>req.body).then(
    (subjects) => { 
      res.status(200);
      res.json(subjects);
    }
  );
});

export { router };
