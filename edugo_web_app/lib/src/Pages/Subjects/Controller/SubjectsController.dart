import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Subjects/Model/Data/Subjects.dart';

class SubjectsController extends MomentumController<SubjectsModel> {
  @override
  SubjectsModel init() {
    return SubjectsModel(this, subjectCards: [], subjects: []);
  }

// Info: Get all subjects created by the educator
  Future<void> getEducatorSubjects(context) async {
    var url = Uri.parse('http://34.65.226.152:8080/subject/getSubjectsbyUser');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
    ).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> _subjects = jsonDecode(response.body);
        model.updateSubjects(Subjects.fromJson(_subjects).subjects);
        model.updateSubjectCards();
        return;
      }
    });
  }

  int getSubjectIdByName(String name) {
    int id = 0;
    model.subjects.forEach(
      (subject) {
        if (subject.getSubjectTitle() == name) {
          id = subject.getSubjectId();
          return id;
        }
      },
    );
    return id;
  }
}
