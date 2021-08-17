import 'package:edugo_web_app/src/Pages/EduGo.dart';

class SubjectsModel extends MomentumModel<SubjectsController> {
  final Subject currentSubject;
  final Subject viewBoundSubject;
  SubjectsModel(SubjectsController controller,
      {this.currentSubject, this.viewBoundSubject})
      : super(controller);

  @override
  void update({
    Subject viewBoundSubject,
    Subject currentSubject,
  }) {
    SubjectsModel(
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

  void setCurrentSubject({Subject currentSubject}) {
    update(currentSubject: currentSubject);
  }

  Subject getCurrentSubject() {
    return currentSubject;
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
