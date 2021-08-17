import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Subjects/Model/Data/Subjects.dart';

class SubjectsController extends MomentumController<SubjectsModel> {
  @override
  SubjectsModel init() {
    return SubjectsModel(this, subjectCards: [], subjects: []);
  }

// Info: Get all subjects created by the educator
  Future<void> getEducatorSubjects(context) async {
    var url =
        Uri.parse('http://43e6071f3a8e.ngrok.io/subject/getSubjectsbyUser');
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
        return;
      }
    });
  }
}
