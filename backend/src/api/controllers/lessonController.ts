import express from "express";
import { LessonService } from "../services/LessonService";
import { CreateLessonRequest } from "../interfaces/lessonInterfaces/CreateLessonRequest";
import { GetLessonsBySubjectRequest } from "../interfaces/lessonInterfaces/GetLessonsBySubjectRequest";

const router = express.Router();
const service = new LessonService(); 
router.use((req, res, next) => {
  next();
});

router.post("/createLesson", async (req, res) => {
  //Create lesson
  service.createLesson(<CreateLessonRequest>req.body).then((response) => {
    res.status(200);
    res.json(response);
  });
});

router.post("/getLessonsBySubject", async (req, res) => {
  //Create lesson
  service.GetLessonsBySubject(<GetLessonsBySubjectRequest>req.body).then((response) => {
    res.status(200);
    res.json(response);
  });
});

export { router };
