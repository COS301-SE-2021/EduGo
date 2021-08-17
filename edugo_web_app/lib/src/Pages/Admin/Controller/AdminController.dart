import 'package:edugo_web_app/src/Pages/Admin/Model/Data/User.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class AdminController extends MomentumController<AdminModel> {
  @override
  AdminModel init() {
    return AdminModel(
      this,
      organisationName: "EduGo University",
      educators: [],
    );
  }

  void makeEducatorAdmin(String username) {
    // * Send make admin request

    // * update educators View
    getOrganisationEducatorsView();
  }

  void revokeEducatorAdmin(String username) {
    // * Send make admin request

    // * update educators View
    getOrganisationEducatorsView();
  }

  void getOrganisationEducatorsView() {
    model.updateEducatorsView();
  }

  // Future<void> getOrganisation(context) async {
  //   var url = Uri.parse('http://localhost:8080/organisation/GetOrganisation');
  //   await post(url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization':
  //             Momentum.controller<SessionController>(context).getToken()
  //       },
  //       body: jsonEncode(<String, String>{
  //         "id": model.getOrganisationId(),
  //       })).then((response) {
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> _organisation = jsonDecode(response.body);
  //       model.update(organisationName: _organisation["organisation_name"]);
  //       var subjectObjsJson = jsonDecode(_organisation['subjects']) as List;
  //       model.update(
  //           subjects: subjectObjsJson
  //               .map((subjectJson) => Subject.fromJson(subjectJson))
  //               .toList());
  //       return;
  //     }
  //   });
  // }

  void setToken(String token) {
    model.setToken(token);
  }

  void setCurrentSubjectId(int id) {
    model.setCurrentSubjectId(id);
  }

  void setCurrentLessonId(int id) {
    model.setCurrentLessonId(id);
  }

  int getCurrentSubjectId() {
    return model.getCurrentSubjectId();
  }

  int getCurrentLessonId() {
    return model.getCurrentLessonId();
  }

  String getToken() {
    return model.getToken();
  }

  void getOrganisationEducators() {
    List<User> educators = [];
    //*make request to get organisation educators and map to User object
    for (int i = 0; i < 10; i++) {
      User user = new User(
        name: "Educator: " + i.toString(),
        admin: false,
      );
      educators.add(user);
    }
    model.updateEducators(educators);
    getOrganisationEducatorsView();
  }
}
