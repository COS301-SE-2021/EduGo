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

  Future<String> createLesson(context) async {
    model.update(createLessonLoadController: false);
    var url =
        Uri.parse(EduGoHttpModule().getBaseUrl() + '/lesson/createLesson');
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
        if (response.statusCode == 200) {
          model.update(createRepsonse: "Lesson created");

          model.update(createLessonLoadController: true);
        } else {
          model.update(createRepsonse: "Lesson not created");
          model.update(createLessonLoadController: true);
        }
      },
    );
    return model.createRepsonse;
  }
}
