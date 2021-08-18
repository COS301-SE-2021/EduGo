import 'package:edugo_web_app/src/Pages/Admin/Model/Data/User.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:http/http.dart' as http;

class AdminController extends MomentumController<AdminModel> {
  @override
  AdminModel init() {
    return AdminModel(this,
        organisationName: "", educators: [], virtualEntityViewerModelLink: "");
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

  void setVirtualEntity3dModelLink(String link) {
    model.setVirtualEntityViewerModelLink(link);
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

  Future<void> getOrganisationId() async {
    var url = Uri.parse('http://34.65.226.152:8080/user/getUserDetails');
    await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': getToken()
      },
    ).then((response) async {
      Map<String, dynamic> _user = jsonDecode(response.body);
      if (response.statusCode == 200) {
        int organisationId = _user['organisation_id'];
        await getOrganisationName(organisationId);
      }
    });
  }

  Future<void> getOrganisationName(int id) async {
    var url =
        Uri.parse('http://34.65.226.152:8080/organisation/getOrganisation');
    await http
        .post(url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': getToken()
            },
            body: jsonEncode(<String, int>{"id": id}))
        .then((response) {
      Map<String, dynamic> _organisation = jsonDecode(response.body);
      if (response.statusCode == 200) {
        String organisationName = _organisation['organisation_name'];
        model.setOrganisationName(organisationName);
      }
    });
  }
}
