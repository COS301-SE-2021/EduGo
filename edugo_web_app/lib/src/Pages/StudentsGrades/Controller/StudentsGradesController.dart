import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/StudentsGrades/Model/Data/Subjects.dart';

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
          Map<String, dynamic> _subjects = jsonDecode(response.body);
          model.updateSubjects(Subjects.fromJson(_subjects).subjects);
          model.updateStudentCards(index: 0);
          model.update(
              currentSubject: model.subjects.isEmpty
                  ? null
                  : model.subjects[0].getSubjectName());
          model.updateSubjectsStrings();

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
    model.updateStudentCards(index: index);
  }
}
