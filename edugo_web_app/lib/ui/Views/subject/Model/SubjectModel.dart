import 'package:edugo_web_app/ui/Views/subject/Controller/SubjectController.dart';
import 'package:momentum/momentum.dart';

class SubjectModel extends MomentumModel<SubjectController> {
  final String subjectTitle;
  final String subjectGrade;
  final String subjectDesctiprion;
  //final Lesson
  final String subjectID;

  SubjectModel(SubjectController controller,
      {this.subjectTitle,
      this.subjectGrade,
      this.subjectDesctiprion,
      this.subjectID})
      : super(controller);

  @override
  void update(
      {String subjectTitle,
      String subjectGrade,
      String subjectDesctiprion,
      String subjectID}) {
    SubjectModel(
      controller,
      subjectTitle: subjectTitle ?? this.subjectTitle,
      subjectGrade: subjectGrade ?? this.subjectGrade,
      subjectDesctiprion: subjectDesctiprion ?? this.subjectDesctiprion,
      subjectID: subjectID ?? this.subjectID,
    ).updateMomentum();
  }

  void updateSubjectTitle({String subjectTitle}) {
    update(subjectTitle: subjectTitle);
  }

  void updateSubjectGrade({String subjectGrade}) {
    update(subjectGrade: subjectGrade);
  }
}
