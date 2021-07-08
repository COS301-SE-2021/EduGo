import 'package:edugo_web_app/ui/Views/subject/Controller/SubjectController.dart';
import 'package:momentum/momentum.dart';

class SubjectModel extends MomentumModel<SubjectController> {
  final String subjectTitle;
  final String subjectGrade;

  SubjectModel(SubjectController controller,
      {this.subjectTitle, this.subjectGrade})
      : super(controller);

  @override
  void update({
    String subjectTitle,
    String subjectGrade,
  }) {
    SubjectModel(controller,
            subjectTitle: subjectTitle ?? this.subjectTitle,
            subjectGrade: subjectGrade ?? this.subjectGrade)
        .updateMomentum();
  }

  void updateSubjectTitle({String subjectTitle}) {
    update(subjectTitle: subjectTitle);
  }

  void updateSubjectGrade({String subjectGrade}) {
    update(subjectGrade: subjectGrade);
  }
}
