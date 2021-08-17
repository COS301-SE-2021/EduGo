import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateLessonController extends MomentumController<CreateLessonModel> {
  @override
  CreateLessonModel init() {
    return CreateLessonModel(
      this,
    );
  }

  void setLessonTitle(String lessonTitle) {
    model.setLessonTitle(lessonTitle);
  }

  void setLessonDescription(String lessonDescription) {
    model.setLessonDescription(lessonDescription);
  }

  Future createLesson(context) async {
    var url = Uri.parse('http://localhost:8080/lesson/createLesson');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
      body: jsonEncode(
        <String, String>{
          "title": model.lessonTitle,
          "description": model.lessonDescription,
          "subjectId": Momentum.controller<AdminController>(context)
              .getCurrentSubjectId()
              .toString()
        },
      ),
    ).then(
      (value) => {
        MomentumRouter.goto(context, LessonsView),
      },
    );
  }
}
