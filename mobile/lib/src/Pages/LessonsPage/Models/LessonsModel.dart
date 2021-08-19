/**
 * This is the model for the LessonPage itself. 
 * The getLessonsBySubject endpoint will return a list of lessons.  
 */

import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/Lesson.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *             Lesson model class for the actual LessonPage
 *------------------------------------------------------------------------------
 */

//Momentum constructor
class LessonsModel extends MomentumModel<LessonsController> {
  LessonsModel(LessonsController controller, {required this.lessons})
      : super(controller);

  //List of lessons to return
  final List<Lesson> lessons;

  //Used by mvc momentum to update lesson model
  @override
  void update({List<Lesson>? lessons}) {
    LessonsModel(controller, lessons: lessons ?? this.lessons).updateMomentum();
  }
}
