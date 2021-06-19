import { CreateLessonRequest } from "../models/CreateLessonRequest";
import { GetLessonsBySubjectResponse } from "../models/GetLessonsBySubjectResponse";
import { ApiResponse } from "../../models/apiResponse";
import { Lesson } from "../../database/entity/Lesson";
import { Any, createConnection, getConnection } from "typeorm";
import { GetLessonsBySubjectRequest } from "../models/GetLessonsBySubjectRequest";
import { Subject } from "../../database/entity/Subject";

let statusRes: ApiResponse = {
  message: "",
  type: "fail",
};

export async function createLesson(request: CreateLessonRequest) {
  if (
    request.title == null ||
    request.date == null ||
    request.description == null ||
    request.subjectId == null
  ) {
    statusRes.message = "Missing parameters";
    statusRes.type = "fail";
    return statusRes;
  } else {
    let conn = getConnection();
    let lesson: Lesson = new Lesson();

    lesson.title = request.title;
    lesson.description = request.description;
    lesson.date = request.date;
    
    let subjectRepository = conn.getRepository(Subject);
    return subjectRepository
      .save({ id: request.subjectId, lessons: [lesson] })
      .then((value) => {
        statusRes.message = `Successfully added lesson `;
        statusRes.type = "success";
        return value;
      })
      .catch((err) => {
        statusRes.message = err.message;
        statusRes.type = "fail";
        return statusRes;
      });
  }
}

export async function GetLessonsBySubject(request: GetLessonsBySubjectRequest) {
  if (request.subjectId == null) {
    statusRes.message = "SubjectId not provided" + JSON.stringify(request);
    return statusRes;
  } else {
    let conn = getConnection();
    let subjectRepository = conn.getRepository(Subject);
    return subjectRepository
      .findOne({ where: { id: request.subjectId } })
      .then((subject) => {
        if (subject) {
          let lessons = subject.lessons;
          let LessonsData: GetLessonsBySubjectResponse = {
            data: lessons,
            statusMessage: "Successful",
          };
          return LessonsData;
        } else {
          statusRes.message = "The Subject doesn't exist";
          statusRes.type = "fail";
          return statusRes;
        }
      })
      .catch(() => {
        statusRes.message =
          "There was an error getting lessons for subjectId provided";
        statusRes.type = "fail";
        return statusRes;
      });
  }
}
