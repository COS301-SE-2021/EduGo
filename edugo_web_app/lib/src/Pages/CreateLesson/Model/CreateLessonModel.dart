import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateLessonModel extends MomentumModel<CreateLessonController> {
  final String lessonTitle;
  final String lessonDescription;
  CreateLessonModel(CreateLessonController controller,
      {this.lessonTitle, this.lessonDescription})
      : super(controller);

  void setLessonTitle(String lessonTitle) {
    update(lessonTitle: lessonTitle);
  }

  void setLessonDescription(String lessonDescription) {
    update(lessonDescription: lessonDescription);
  }

  @override
  void update({
    String lessonTitle,
    String lessonDescription,
  }) {
    CreateLessonModel(
      controller,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      lessonDescription: lessonDescription ?? this.lessonDescription,
    ).updateMomentum();
  }
}
