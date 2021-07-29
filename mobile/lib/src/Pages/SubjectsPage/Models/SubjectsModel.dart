import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/Subject.dart';
import 'package:momentum/momentum.dart';

class SubjectsModel extends MomentumModel<SubjectsController> {
  SubjectsModel(
    SubjectsController controller,
    {required this.subjects}
  ) : super(controller);

  final List<Subject> subjects;

  @override
  void update({List<Subject>? subjects}) {
    SubjectsModel(controller, subjects: subjects ?? this.subjects).updateMomentum();
  }
}