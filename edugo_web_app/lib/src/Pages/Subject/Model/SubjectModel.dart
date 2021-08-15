import 'package:edugo_web_app/src/Pages/EduGo.dart';

class SubjectModel extends MomentumModel<SubjectController> {
  final Subject currentSubject;
  final Subject viewBoundSubject;
  SubjectModel(SubjectController controller,
      {this.currentSubject, this.viewBoundSubject})
      : super(controller);

  @override
  void update({
    Subject viewBoundSubject,
    Subject currentSubject,
  }) {
    SubjectModel(
      controller,
      viewBoundSubject: currentSubject ?? this.currentSubject,
      currentSubject: currentSubject ?? this.currentSubject,
    ).updateMomentum();
  }

  void setViewBoundSubjectTitle({String subjectTitle}) {
    Subject temporarySubject = viewBoundSubject;
    temporarySubject.setSubjectTitle(subjectTitle);
    update(viewBoundSubject: temporarySubject);
  }

  void setViewBoundSubjectGrade({String subjectGrade}) {
    Subject temporarySubject = viewBoundSubject;
    temporarySubject.setSubjectGrade(subjectGrade);
    update(viewBoundSubject: temporarySubject);
  }

  String getViewBoundSubjectTitle() {
    return viewBoundSubject.getSubjectTitle();
  }

  String getViewBoundSubjectGrade() {
    return viewBoundSubject.getSubjectGrade();
  }

  String getViewBoundSubjectImageLink() {
    return viewBoundSubject.getSubjectImageLink();
  }
}
