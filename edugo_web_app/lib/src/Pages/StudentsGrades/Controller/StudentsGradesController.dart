import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/StudentsGrades/Model/Data/Subject.dart';
import 'package:edugo_web_app/src/Pages/StudentsGrades/Model/Data/Subjects.dart';
import 'package:edugo_web_app/src/Pages/StudentsGrades/View/Widgets/StudentsGradesWidgets.dart';

class StudentsGradesController extends MomentumController<StudentsGradesModel> {
  @override
  StudentsGradesModel init() {
    return StudentsGradesModel(this,
        studentCards: [], subjects: [], subjectsStrings: []);
  }

// Info: Get all student results for educator
  Future<void> getEducatorGrades(context) async {
    var url =
        Uri.parse(EduGoHttpModule().getBaseUrl() + '/user/getGradesByEducator');
    await get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
    ).then(
      (response) {
        if (response.statusCode == 200) {
          dynamic _subjects = jsonDecode(response.body);
          updateSubjects(Subjects.fromJson(_subjects).subjects);
          updateStudentCards(index: 0);
          model.update(
            currentSubject: model.subjects.isEmpty
                ? null
                : model.subjects[0].getSubjectName(),
          );
          updateSubjectsStrings();
          return;
        }
      },
    );
  }

  void selectSubject({String name}) {
    model.update(currentSubject: name);
    int index = 0;
    model.subjects.forEach(
      (subject) {
        if (subject.getSubjectName() == name) {
          return;
        }
        index++;
      },
    );
    updateStudentCards(index: index);
  }

// Info: Update student cards
  void updateStudentCards({int index}) {
    List<Widget> studentCardsUpdate = [];
    if (model.subjects.isNotEmpty) {
      model.subjects[index].getStudents().forEach(
        (student) {
          studentCardsUpdate.add(
            new StudentsGradesCard(
              name: student.getName(),
              grade: student.getGrade(),
            ),
          );
        },
      );
      if (model.subjects[index].getStudents().isEmpty) {
        studentCardsUpdate.add(Text("No grades"));
      }
    } else {
      studentCardsUpdate.add(Text("No grades"));
    }

    model.update(studentCards: studentCardsUpdate);
  }

  // Info: Update list of subjects strings
  void updateSubjectsStrings() {
    List<String> subjectsUpdate = [];
    if (model.subjects.isNotEmpty) {
      model.subjects.forEach(
        (subject) {
          subjectsUpdate.add(
            subject.getSubjectName(),
          );
        },
      );
    }
    model.update(subjectsStrings: subjectsUpdate);
  }

  // Info: Update list of subjects
  void updateSubjects(List<Subject> subjectsUpdate) {
    model.update(subjects: subjectsUpdate);
  }
}
