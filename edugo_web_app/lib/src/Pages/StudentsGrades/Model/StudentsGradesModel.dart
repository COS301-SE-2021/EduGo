import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/StudentsGrades/Model/Data/Subject.dart';
import 'package:edugo_web_app/src/Pages/StudentsGrades/View/Widgets/StudentsGradesWidgets.dart';

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

// Info: Update list of subjects
  void updateSubjects(List<Subject> subjectsUpdate) {
    update(subjects: subjectsUpdate);
  }

// Info: Update list of subjects strings
  void updateSubjectsStrings() {
    List<String> subjectsUpdate = [];
    if (subjects.isNotEmpty) {
      subjects.forEach(
        (subject) {
          subjectsStrings.add(
            subject.getSubjectName(),
          );
        },
      );
    }
    update(subjectsStrings: subjectsUpdate);
  }

// Info: Update student cards
  void updateStudentCards({int index}) {
    List<Widget> studentCardsUpdate = [];
    if (subjects.isNotEmpty) {
      subjects[index].getStudents().forEach(
        (student) {
          studentCardsUpdate.add(
            new StudentsGradesCard(
              name: student.getName(),
              grade: student.getGrade(),
            ),
          );
        },
      );
      if (subjects[index].getStudents().isEmpty) {
        studentCardsUpdate.add(Text("No grades"));
      }
    } else {
      studentCardsUpdate.add(Text("No grades"));
    }

    update(studentCards: studentCardsUpdate);
  }

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
