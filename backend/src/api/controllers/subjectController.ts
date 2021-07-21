import express from "express";
import { SubjectService } from "../services/SubjectService";
import { CreateSubjectRequest } from "../interfaces/subjectInterfaces/CreateSubjectRequest";
import { GetSubjectsByEducatorRequest } from "../interfaces/subjectInterfaces/GetSubjectsByEducatorRequest";

const router = express.Router();

const service: SubjectService = new SubjectService();

router.post("/createSubject", async (req, res) => {
  //Create subject
  service.CreateSubject(<CreateSubjectRequest>req.body).then(subjectResponse => {
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
