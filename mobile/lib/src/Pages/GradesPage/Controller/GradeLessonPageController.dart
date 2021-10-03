import 'package:mobile/src/Pages/GradesPage/Model/GradeLessonPageModel.dart';
import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';
import 'package:momentum/momentum.dart';

class GradeLessonPageController extends MomentumController<GradeLessonPageModel> {
  @override
  GradeLessonPageModel init() {
    return GradeLessonPageModel(this, []);
  }

  void setList(List<Lesson> lessonList) {
    model.update(lessonList: lessonList);
  }
}