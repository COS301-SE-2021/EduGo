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
    var url = Uri.parse('http://34.65.226.152:8080/lesson/createLesson');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
      body: jsonEncode(
        <String, dynamic>{
          "title": model.lessonTitle,
          "description": model.lessonDescription,
          "subjectId": Momentum.controller<AdminController>(context)
              .getCurrentSubjectId()
        },
      ),
    ).then(
      (response) {
        print(response.body);
        if (response.statusCode == 200)
          MomentumRouter.goto(context, LessonsView);
      },
    );
  }
}
