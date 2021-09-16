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
  LessonsModel(
    LessonsController controller, {
    required this.lessons,
    required this.id,
    required this.title,
  }) : super(controller);

  //List of lessons to return
  final List<Lesson> lessons;
  final int id;
  final String title;

  //Used by mvc momentum to update lesson model
  @override
  void update({
    List<Lesson>? lessons,
    int? id,
    String? title,
  }) {
    LessonsModel(controller,
            lessons: lessons ?? this.lessons,
            id: id ?? this.id,
            title: title ?? this.title)
        .updateMomentum();
  }
}
