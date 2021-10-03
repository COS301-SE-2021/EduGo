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
            description: lesson.getLessonDescription(),
          ),
        );
      },
    );
    if (lessons.isEmpty) {
      lessonCardsUpdate.add(
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150, bottom: 30),
                child: Icon(
                  Icons.new_releases_outlined,
                  size: 150,
                  color: Color.fromARGB(255, 97, 211, 87),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "No Les",
                    style: TextStyle(
                      fontSize: 45,
                    ),
                  ),
                  Text(
                    "sons",
                    style: TextStyle(
                      fontSize: 45,
                      color: Color.fromARGB(255, 97, 211, 87),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

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
