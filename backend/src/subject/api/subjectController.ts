import express from "express";
import { GetLessonsBySubjectRequest } from "../../lesson/models/GetLessonsBySubjectRequest";
import { GetSubjectsByEducator } from "../../subject/service/subjectService";
import { CreateSubjectRequest } from "../model/CreateSubjectRequest";
import { GetSubjectsByEducatorRequest } from "../model/GetSubjectsByEducatorRequest";
import { createSubject } from "../service/subjectService";

const router = express.Router();

router.use((req, res, next) => {
  next();
});

router.post("/createSubject", async (req, res) => {
  //Create subject
  createSubject(<CreateSubjectRequest>req.body).then((subjectResponse) => {
    res.status(200);
    res.json(subjectResponse);
  });
});

router.get("/getSubjectsByEducator", async (req, res) => {
  //Create lesson
  GetSubjectsByEducator(<GetSubjectsByEducatorRequest>req.body).then(
    (subjects) => {
      res.status(200);
      res.json(subjects);
    }
  );
});

export { router };
