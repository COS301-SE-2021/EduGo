import 'package:edugo_web_app/src/Pages/EduGo.dart';

class LessonController extends MomentumController<LessonModel> {
  @override
  LessonModel init() {
    return LessonModel(this,
        viewBoundLesson: Lesson(), currentLesson: Lesson());
  }

  void setViewBoundLessonTitle(String lessonTitle) {
    model.setViewBoundLessonTitle(lessonTitle: lessonTitle);
  }

  void setViewBoundLessonDescription(String lessonDescription) {
    model.setViewBoundLessonDescription(lessonDescription: lessonDescription);
  }

  void setViewBoundLessonSubjectId(String lessonSubjectId) {
    model.setViewBoundLessonSubjectId(lessonSubjectID: lessonSubjectId);
  }

  Future createLesson(context) async {
    var currentSubjectController = controller<SubjectController>();
    var url = Uri.parse('http://localhost:8080/lesson/createLesson');
    await post(url, headers: {
      'contentType': 'application/json',
    }, body: {
      "title": model.viewBoundLesson.getLessonTitle(),
      "description": model.viewBoundLesson.getLessonDescription(),
      "subjectId": currentSubjectController.getCurrentSubjectId()
    }).then((value) => {MomentumRouter.goto(context, SubjectsView)});
  }
}
