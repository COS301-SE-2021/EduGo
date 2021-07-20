import express from "express";
import { createLesson, GetLessonsBySubject } from "../services/lessonService";
import { CreateLessonRequest } from "../interfaces/lessonInterfaces/CreateLessonRequest";
import { GetLessonsBySubjectRequest } from "../interfaces/lessonInterfaces/GetLessonsBySubjectRequest";

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
