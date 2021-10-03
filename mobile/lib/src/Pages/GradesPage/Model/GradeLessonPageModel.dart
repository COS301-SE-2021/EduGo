import 'package:mobile/src/Pages/GradesPage/Controller/GradeLessonPageController.dart';
import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';
import 'package:momentum/momentum.dart';

class GradeLessonPageModel extends MomentumModel<GradeLessonPageController> {
  GradeLessonPageModel(GradeLessonPageController controller, this.lessonList) : super(controller);

  final List<Lesson> lessonList;

  @override
  void update({List<Lesson>? lessonList}) {
    GradeLessonPageModel(controller, lessonList ?? this.lessonList).updateMomentum();
  }

}