import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateSubjectModel extends MomentumModel<CreateSubjectController> {
  final String subjectTitle;
  final String subjectGrade;
  final String subjectImage;

  CreateSubjectModel(
    CreateSubjectController controller, {
    this.subjectTitle,
    this.subjectGrade,
    this.subjectImage,
  }) : super(controller);

  @override
  void update({String subjectTitle, String subjectGrade, String subjectImage}) {
    CreateSubjectModel(controller,
            subjectTitle: subjectTitle ?? this.subjectTitle,
            subjectGrade: subjectGrade ?? this.subjectGrade,
            subjectImage: subjectImage ?? this.subjectImage)
        .updateMomentum();
  }

  void setSubjectTitle(String subjectTitle) {
    update(subjectTitle: subjectTitle);
  }

  void setSubjectGrade(String subjectGrade) {
    update(subjectGrade: subjectGrade);
  }
}
