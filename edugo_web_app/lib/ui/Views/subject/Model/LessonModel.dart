import 'package:edugo_web_app/ui/Views/subject/Controller/LessonController.dart';
import 'package:momentum/momentum.dart';

class LessonModel extends MomentumModel<LessonController> {
  final String lessonTitle;
  final String lessonDate;
  final String lessonDesctiprion;
  //final Lesson
  final String lessonID;

  LessonModel(LessonController controller,
      {this.lessonTitle,
      this.lessonDate,
      this.lessonDesctiprion,
      this.lessonID})
      : super(controller);

  @override
  void update(
      {String lessonTitle,
      String lessonDate,
      String lessonDesctiprion,
      String lessonID}) {
    LessonModel(
      controller,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      lessonDate: lessonDate ?? this.lessonDate,
      lessonDesctiprion: lessonDesctiprion ?? this.lessonDesctiprion,
      lessonID: lessonID ?? this.lessonID,
    ).updateMomentum();
  }

  void updateSubjectTitle({String lessonTitle}) {
    update(lessonTitle: lessonTitle);
  }

  void updateSubjectGrade({String lessonDate}) {
    update(lessonDate: lessonDate);
  }

  void updateLessonDesctiprion({String lessonDesctiprion}) {
    update(lessonDesctiprion: lessonDesctiprion);
  }

  void updateLessonID({String lessonID}) {
    update(lessonID: lessonID);
  }
}
