import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';
import 'package:momentum/momentum.dart';

class GradeLessonPageParam extends RouterParam {
  final List<Lesson> lessonList;

  GradeLessonPageParam({required this.lessonList});
}