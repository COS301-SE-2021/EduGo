/**
 * This is the model for the SubjectPage itself. 
 * The getSubjectsByUser endpoint will return a list of subjects.  
*/

import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/Subject.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *             Subject model class for the actual SubjectPage
 *------------------------------------------------------------------------------
*/

//Momentum constructor
class SubjectsModel extends MomentumModel<SubjectsController> {
  SubjectsModel(SubjectsController controller, {required this.subjects})
      : super(controller);

  //List of subjects to return
  final List<Subject> subjects;

  //Used by mvc momentum to update subject model
  @override
  void update({List<Subject>? subjects}) {
    SubjectsModel(controller, subjects: subjects ?? this.subjects)
        .updateMomentum();
  }
}
