import express from "express";
import { createLesson, GetLessonsBySubject } from "../service/lessonService";
import { CreateLessonRequest } from "../models/CreateLessonRequest";
import { GetLessonsBySubjectRequest } from "../models/GetLessonsBySubjectRequest";

const router = express.Router();

router.use((req, res, next) => {
  next();
});

router.post("/createLesson", async (req, res) => {
  //Create lesson
  createLesson(<CreateLessonRequest>req.body).then((response) => {
    res.status(200);
    res.json(response);
  });
});

router.post("/getLessonsBySubject", async (req, res) => {
  //Create lesson
  GetLessonsBySubject(<GetLessonsBySubjectRequest>req.body).then((response) => {
    res.status(200);
    res.json(response);
  });
});

export { router };
