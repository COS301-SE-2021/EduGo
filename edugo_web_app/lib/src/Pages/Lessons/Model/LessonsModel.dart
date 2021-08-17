import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Lessons/Model/Data/Lesson.dart';
import 'package:edugo_web_app/src/Pages/Lessons/View/Widgets/LessonsWidgets.dart';

class LessonsModel extends MomentumModel<LessonsController> {
  final List<Lesson> lessons;
  final List<Widget> lessonCards;
  LessonsModel(LessonsController controller, {this.lessons, this.lessonCards})
      : super(controller);

// Info: Update list of lessons
  void updateLessons(List<Lesson> lessonsUpdate) {
    update(lessons: lessonsUpdate);
    updateLessonCards();
  }

// Info: Update lesson cards
  void updateLessonCards() {
    List<Widget> lessonCardsUpdate = [];
    lessons.forEach(
      (lesson) {
        lessonCardsUpdate.add(
          new LessonsCard(
            title: lesson.getLessonTitle(),
            id: lesson.getLessonId(),
          ),
        );
      },
    );
    update(lessonCards: lessonCardsUpdate);
  }

  @override
  void update({
    List<Lesson> lessons,
    List<Widget> lessonCards,
  }) {
    LessonsModel(
      controller,
      lessons: lessons ?? this.lessons,
      lessonCards: lessonCards ?? this.lessonCards,
    ).updateMomentum();
  }
}
