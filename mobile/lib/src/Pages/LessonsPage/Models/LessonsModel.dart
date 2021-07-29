import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/Lesson.dart';
import 'package:momentum/momentum.dart';

class LessonsModel extends MomentumModel<LessonsController> {
  LessonsModel(
    LessonsController controller, 
    {required this.lessons}) : super(controller);

  final List<Lesson> lessons;

  @override
  void update({List<Lesson>? lessons}) {
    LessonsModel(controller, lessons: lessons ?? this.lessons).updateMomentum();
  }

}