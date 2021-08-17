import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateSubjectModel extends MomentumModel<CreateSubjectController> {
  final String subjectTitle;
  final String subjectGrade;
  CreateSubjectModel(CreateSubjectController controller,
      {this.subjectTitle, this.subjectGrade})
      : super(controller);

  @override
  void update({
    String subjectTitle,
    String subjectGrade,
  }) {
    CreateSubjectModel(
      controller,
      subjectTitle: subjectTitle ?? this.subjectTitle,
      subjectGrade: subjectGrade ?? this.subjectGrade,
    ).updateMomentum();
  }

  void setSubjectTitle(String subjectTitle) {
    update(subjectTitle: subjectTitle);
  }

  void setSubjectGrade(String subjectGrade) {
    update(subjectGrade: subjectGrade);
  }
}
