import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/StudentsGrades/Model/Data/Subject.dart';

class StudentsGradesModel extends MomentumModel<StudentsGradesController> {
  final List<Subject> subjects;
  final List<Widget> studentCards;
  final List<String> subjectsStrings;
  final String currentSubject;

  StudentsGradesModel(StudentsGradesController controller,
      {this.subjects,
      this.studentCards,
      this.subjectsStrings,
      this.currentSubject})
      : super(controller);

  @override
  void update({
    List<Subject> subjects,
    List<Widget> studentCards,
    List<String> subjectsStrings,
    String currentSubject,
  }) {
    StudentsGradesModel(controller,
            subjects: subjects ?? this.subjects,
            studentCards: studentCards ?? this.studentCards,
            subjectsStrings: subjectsStrings ?? this.subjectsStrings,
            currentSubject: currentSubject ?? this.currentSubject)
        .updateMomentum();
  }
}
