import 'package:edugo_web_app/src/Pages/EduGo.dart';

class LessonModel extends MomentumModel<LessonController> {
  final Lesson currentLesson;
  final Lesson viewBoundLesson;
  LessonModel(LessonController controller,
      {this.currentLesson, this.viewBoundLesson})
      : super(controller);

  @override
  void update({
    Lesson viewBoundLesson,
    Lesson currentLesson,
  }) {
    LessonModel(
      controller,
      viewBoundLesson: currentLesson ?? this.currentLesson,
      currentLesson: currentLesson ?? this.currentLesson,
    ).updateMomentum();
  }

  void setViewBoundLessonTitle({String lessonTitle}) {
    Lesson temporaryLesson = viewBoundLesson;
    temporaryLesson.setLessonTitle(lessonTitle);
    update(viewBoundLesson: temporaryLesson);
  }

  void setViewBoundLessonDescription({String lessonDescription}) {
    Lesson temporaryLesson = viewBoundLesson;
    temporaryLesson.setLessonDescription(lessonDescription);
    update(viewBoundLesson: temporaryLesson);
  }

  void setViewBoundLessonImageLink({String lessonImage}) {
    Lesson temporaryLesson = viewBoundLesson;
    temporaryLesson.setLessonImageLink(lessonImage);
    update(viewBoundLesson: temporaryLesson);
  }

  void setViewBoundLessonDate({String lessonDate}) {
    Lesson temporaryLesson = viewBoundLesson;
    temporaryLesson.setLessonDate(lessonDate);
    update(viewBoundLesson: temporaryLesson);
  }

  void setViewBoundLessonTime({String lessonTime}) {
    Lesson temporaryLesson = viewBoundLesson;
    temporaryLesson.setLessonTime(lessonTime);
    update(viewBoundLesson: temporaryLesson);
  }

  void setViewBoundLessonVirtualEntityId({String lessonVirtualEntityID}) {
    Lesson temporaryLesson = viewBoundLesson;
    temporaryLesson.setLessonVirtualEntityId(lessonVirtualEntityID);
    update(viewBoundLesson: temporaryLesson);
  }

  void setViewBoundLessonSubjectId({String lessonSubjectID}) {
    Lesson temporaryLesson = viewBoundLesson;
    temporaryLesson.setLessonSubjectId(lessonSubjectID);
    update(viewBoundLesson: temporaryLesson);
  }

  String getViewBoundLessonTitle() {
    return viewBoundLesson.getLessonTitle();
  }

  String getViewBoundLessonVirtualEntityId() {
    return viewBoundLesson.getLessonVirtualEntityID();
  }

  String getViewBoundLessonSubjectId() {
    return viewBoundLesson.getLessonSubjectId();
  }

  String getViewBoundLessonDescription() {
    return viewBoundLesson.getLessonDescription();
  }

  String getViewBoundLessonImageLink() {
    return viewBoundLesson.getLessonImageLink();
  }

  String getViewBoundLessonDate() {
    return viewBoundLesson.getLessonDate();
  }

  String getViewBoundLessonTime() {
    return viewBoundLesson.getLessonTime();
  }
}
