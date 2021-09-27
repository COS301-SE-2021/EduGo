import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateLessonModel extends MomentumModel<CreateLessonController> {
  final String lessonTitle;
  final String lessonDescription;
  final bool createLessonLoadController;
  final String createRepsonse;
  CreateLessonModel(
    CreateLessonController controller, {
    this.lessonTitle,
    this.lessonDescription,
    this.createLessonLoadController,
    this.createRepsonse,
  }) : super(controller);

  void setLessonTitle(String lessonTitle) {
    update(lessonTitle: lessonTitle);
  }

  void setLessonDescription(String lessonDescription) {
    update(lessonDescription: lessonDescription);
  }

  @override
  void update(
      {String lessonTitle,
      String lessonDescription,
      bool createLessonLoadController,
      String createRepsonse}) {
    CreateLessonModel(
      controller,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      lessonDescription: lessonDescription ?? this.lessonDescription,
      createLessonLoadController:
          createLessonLoadController ?? this.createLessonLoadController,
      createRepsonse: createRepsonse ?? this.createRepsonse,
    ).updateMomentum();
  }
}
