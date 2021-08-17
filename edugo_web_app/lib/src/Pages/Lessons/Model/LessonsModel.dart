import 'package:edugo_web_app/src/Pages/EduGo.dart';

class LessonsModel extends MomentumModel<LessonsController> {
  final Lesson currentLesson;
  final Lesson viewBoundLesson;
  LessonsModel(LessonsController controller,
      {this.currentLesson, this.viewBoundLesson})
      : super(controller);

  @override
  void update({
    Lesson viewBoundLesson,
    Lesson currentLesson,
  }) {
    LessonsModel(
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

  void setCurrentLessonTitle({String lessonTitle}) {
    Lesson temporaryLesson = currentLesson;
    temporaryLesson.setLessonTitle(lessonTitle);
    update(currentLesson: temporaryLesson);
  }

  void setCurrentLessonDescription({String lessonDescription}) {
    Lesson temporaryLesson = currentLesson;
    temporaryLesson.setLessonDescription(lessonDescription);
    update(currentLesson: temporaryLesson);
  }

  // void addViewBoundLessonVirtualEntity({VirtualEntity lessonVirtualEntity}) {
  //   Lesson temporaryLesson = viewBoundLesson;
  //   temporaryLesson.addLessonVirtualEntity(lessonVirtualEntity);
  //   update(viewBoundLesson: temporaryLesson);
  // }

  // void addCurrentLessonVirtualEntity({VirtualEntity lessonVirtualEntity}) {
  //   Lesson temporaryLesson = currentLesson;
  //   temporaryLesson.addLessonVirtualEntity(lessonVirtualEntity);
  //   update(currentLesson: temporaryLesson);
  // }

  String getViewBoundLessonTitle() {
    return viewBoundLesson.getLessonTitle();
  }

  String getViewBoundLessonDescription() {
    return viewBoundLesson.getLessonDescription();
  }

  // List<VirtualEntity> getViewBoundLessonVirtualEntities() {
  //   return viewBoundLesson.getLessonVirtualEntities();
  // }

  // List<VirtualEntity> getCurrentLessonVirtualEntities() {
  //   return currentLessonss.getLessonVirtualEntities();
  // }
}
