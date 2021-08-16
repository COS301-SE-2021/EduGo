import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Home/Model/Data/User.dart';
import 'package:edugo_web_app/src/Pages/Lesson/Model/Data/Lessons.dart';
import 'package:edugo_web_app/src/Pages/Subject/Model/Data/Subjects.dart';

class CurrentOrganisationController
    extends MomentumController<CurrentOrganisationModel> {
  @override
  CurrentOrganisationModel init() {
    return CurrentOrganisationModel(this,
        organisationName: "EduGo University",
        educators: [],
        educatorsView: [],
        subjectsView: [],
        subjects: [],
        lessons: [],
        lessonsView: []);
  }

  String getOrganisationName() {
    return model.getOrganisationName();
  }

  String getOrganisationEmail() {
    return model.getOrganisationEmail();
  }

  String getOrganisationPhoneNumber() {
    return model.getOrganisationPhoneNumber();
  }

  void makeEducatorAdmin(int id) {
    // * Send make admin request
    model.updateEducatorsAdmin(id, true);
    // * update educators View
    getOrganisationEducatorsView();
  }

  void revokeEducatorAdmin(int id) {
    // * Send make admin request
    model.updateEducatorsAdmin(id, false);
    // * update educators View
    getOrganisationEducatorsView();
  }

  void getOrganisationEducators() {
    List<User> educators = [];
    //*make request to get organisation educators and map to User object
    for (int i = 0; i < 10; i++) {
      User user = new User();
      user.name = "Educator: " + i.toString();
      user.admin = false;
      user.id = i;
      educators.add(user);
    }
    model.updateEducators(educators);
    getOrganisationEducatorsView();
  }

  void getOrganisationEducatorsView() {
    model.updateEducatorsView();
  }

  Future<void> getOrganisation(context) async {
    var url = Uri.parse('http://localhost:8080/organisation/GetOrganisation');
    await post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              Momentum.controller<SessionController>(context).getToken()
        },
        body: jsonEncode(<String, String>{
          "id": model.getOrganisationId(),
        })).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> _organisation = jsonDecode(response.body);
        model.update(organisationEmail: _organisation["organisation_email"]);
        model.update(organisationName: _organisation["organisation_name"]);
        var subjectObjsJson = jsonDecode(_organisation['subjects']) as List;
        model.update(
            subjects: subjectObjsJson
                .map((subjectJson) => Subject.fromJson(subjectJson))
                .toList());
        return;
      }
    });
  }

  Future<void> getEducatorSubjectLessons(context) async {
    var url =
        Uri.parse('http://43e6071f3a8e.ngrok.io/lesson/getLessonsBySubject');
    var currentSubjectController = controller<SubjectController>();
    await post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              Momentum.controller<SessionController>(context).getToken()
        },
        body: jsonEncode(<String, int>{
          "subjectId": int.parse(
              currentSubjectController.getCurrentSubject().getSubjectId()),
        })).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> _lessons = jsonDecode(response.body);
        model.update(lessons: Lessons.fromJson(_lessons).lessons);
        model.updateLessonsView();
        MomentumRouter.goto(context, LessonsView);
        return;
      }
    });
  }

  Future<void> getEducatorSubjects(context) async {
    var url =
        Uri.parse('http://43e6071f3a8e.ngrok.io/subject/getSubjectsbyUser');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<SessionController>(context).getToken()
      },
    ).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> _subjects = jsonDecode(response.body);
        model.update(subjects: Subjects.fromJson(_subjects).subjects);
        model.updateSubjectsView();
        return;
      }
    });
  }
}
