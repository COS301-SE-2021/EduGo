import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Subjects/Model/Data/Subjects.dart';

class SubjectsController extends MomentumController<SubjectsModel> {
  @override
  SubjectsModel init() {
    return SubjectsModel(this, subjectCards: [], subjects: []);
  }

// Info: Get all subjects created by the educator
  Future<void> getEducatorSubjects(context) async {
    var url = Uri.parse(
        EduGoHttpModule().getBaseUrl() + '/organisation/getOrganisation');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
      body: jsonEncode(
        <String, int>{
          "id": Momentum.controller<AdminController>(context).getId()
        },
      ),
    ).then(
      (response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> _subjects = jsonDecode(response.body);
          model.updateSubjects(Subjects.fromJson(_subjects).subjects);
          model.updateSubjectCards();
          return;
        }
      },
    );
  }

// Info: Delete a subject created by the educator
  Future<void> deleteSubject(context, {int subjectId}) async {
    var url =
        Uri.parse(EduGoHttpModule().getBaseUrl() + '/subject/deleteSubject/');
    final request = Request("DELETE", url);
    request.headers.addAll(
      <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
    );
    request.body = jsonEncode({"id": subjectId});
    await request.send().then(
      (value) {
        reset();
        getEducatorSubjects(context);
      },
    );
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
