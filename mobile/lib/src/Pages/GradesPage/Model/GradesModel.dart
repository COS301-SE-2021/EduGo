import 'package:mobile/src/Pages/GradesPage/Controller/GradesController.dart';
import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';

import 'package:momentum/momentum.dart';

class GradesModel extends MomentumModel<GradesController> {
  GradesModel(GradesController controller, {required this.subjects})
      : super(controller);

  final List<Subject> subjects;

  @override
  void update({List<Subject>? subjects}) {
    GradesModel(controller, subjects: subjects ?? this.subjects)
        .updateMomentum();
  }
}
