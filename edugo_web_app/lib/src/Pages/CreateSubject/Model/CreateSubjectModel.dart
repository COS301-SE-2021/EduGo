import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateSubjectModel extends MomentumModel<CreateSubjectController> {
  final String subjectTitle;
  final String subjectGrade;
  final String subjectImage;
  final bool createSubjectLoadController;
  final String createRepsonse;

  CreateSubjectModel(
    CreateSubjectController controller, {
    this.subjectTitle,
    this.subjectGrade,
    this.createRepsonse,
    this.createSubjectLoadController,
    this.subjectImage,
  }) : super(controller);

  void setSubjectTitle(String subjectTitle) {
    update(subjectTitle: subjectTitle);
  }

  void setSubjectGrade(String subjectGrade) {
    update(subjectGrade: subjectGrade);
  }

  @override
  void update(
      {String subjectTitle,
      String subjectGrade,
      String subjectImage,
      bool createSubjectLoadController,
      String createRepsonse}) {
    CreateSubjectModel(controller,
            subjectTitle: subjectTitle ?? this.subjectTitle,
            subjectGrade: subjectGrade ?? this.subjectGrade,
            subjectImage: subjectImage ?? this.subjectImage,
            createSubjectLoadController:
                createSubjectLoadController ?? this.createSubjectLoadController,
            createRepsonse: createRepsonse ?? this.createRepsonse)
        .updateMomentum();
  }
}
