import express from "express";
import { SubjectService } from "../services/SubjectService";
import { CreateSubjectRequest } from "../models/subject/CreateSubjectRequest";
import { GetSubjectsByEducatorRequest } from "../models/subject/GetSubjectsByEducatorRequest";
import { isEducator, RequestObjectWithUserId } from "../middleware/validate";

const router = express.Router();

const service: SubjectService = new SubjectService();

router.post("/createSubject",isEducator, async (req:RequestObjectWithUserId, res:any) => {
  //Create subject
  service.CreateSubject(<CreateSubjectRequest>req.body,req.user_id).then(subjectResponse => {
    res.status(200).json(subjectResponse);
  });
});

router.post("/getSubjectsByEducator", async (req, res) => {
  service.GetSubjectsByEducator(<GetSubjectsByEducatorRequest>req.body).then(
    subjects => {
      res.status(200).json(subjects);
    }
  );
});

export { router };
