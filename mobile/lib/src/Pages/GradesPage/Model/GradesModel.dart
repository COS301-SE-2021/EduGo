/**
 * This is the model for the GradesPage itself. 
 * The getStudentGrades endpoint will return a list of subjects.  
*/

import 'package:mobile/src/Pages/GradesPage/Controller/GradesController.dart';
import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *             Grades model class for the actual GradesPage
 *------------------------------------------------------------------------------
 */

//Momentum constructor
class GradesModel extends MomentumModel<GradesController> {
  GradesModel(GradesController controller, {required this.subjects})
      : super(controller);

//List of subjects to return
  final List<Subject> subjects;

  //Used by mvc momentum to update Gradessubject model
  @override
  void update({List<Subject>? subjects}) {
    GradesModel(controller, subjects: subjects ?? this.subjects)
        .updateMomentum();
  }
}
