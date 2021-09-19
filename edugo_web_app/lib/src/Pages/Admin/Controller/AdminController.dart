import 'package:edugo_web_app/src/Pages/Admin/Model/Data/Users.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:http/http.dart' as http;

class AdminController extends MomentumController<AdminModel> {
  @override
  AdminModel init() {
    return AdminModel(this,
        organisationName: "",
        educators: [],
        educatorCards: [],
        virtualEntityViewerModelLink: "");
  }

  void setCurrentSubjectImageLink(String link) {
    model.setCurrentSubjectImage(link);
  }

  String getCurrentSubjectImage() {
    return model.currentSubjectImageLink;
  }

  Future<void> makeEducatorAdmin(String username) async {
    model.update(adminLoadController: false);
    // * Send make admin request
    var url =
        Uri.parse(EduGoHttpModule().getBaseUrl() + '/user/setUserToAdmin');
    await post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': getToken()
        },
        body: jsonEncode(<String, String>{
          "username": username,
        })).then((response) async {
      if (response.statusCode == 200) {
        await getOrganisationEducators().then(
          (value) {
            model.update(adminLoadController: true);
          },
        );
        return;
      }
    });
  }

  Future<void> revokeEducatorAdmin(String username) async {
    model.update(adminLoadController: false);
    // * Send make admin request
    var url =
        Uri.parse(EduGoHttpModule().getBaseUrl() + '/user/revokeUserFromAdmin');
    await post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': getToken()
        },
        body: jsonEncode(<String, String>{
          "username": username,
        })).then((response) async {
      if (response.statusCode == 200) {
        await getOrganisationEducators().then((value) {
          model.update(adminLoadController: true);
        });
        return;
      }
    });
  }

  void getOrganisationEducatorsView() {
    model.updateEducatorsView();
  }

  void setVirtualEntity3dModelLink(String link) {
    model.setVirtualEntityViewerModelLink(link);
  }

  void setUserName(String name) {
    model.setUserName(name);
  }

  Future<void> getOrganisationEducators() async {
    var url = Uri.parse(
        EduGoHttpModule().getBaseUrl() + '/organisation/getOrganisation');
    await post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': getToken()
        },
        body: jsonEncode(<String, int>{
          "id": model.organisationId,
        })).then(
      (response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> _organisation = jsonDecode(response.body);
          model.updateEducators(Users.fromJson(_organisation).users);
          model.updateEducatorsView();

          return;
        }
      },
    );
  }

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

  Future<void> getOrganisationId(context) async {
    model.update(adminLoadController: true);
    var url =
        Uri.parse(EduGoHttpModule().getBaseUrl() + '/user/getUserDetails');
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
        model.setOrganisationId(organisationId);
        await getOrganisationName(organisationId).then((value) {
          Momentum.controller<AdminController>(context)
              .getOrganisationEducators();
        });
      }
    });
  }

  int getId() {
    return model.organisationId;
  }

  Future<void> getOrganisationName(int id) async {
    var url = Uri.parse(
        EduGoHttpModule().getBaseUrl() + '/organisation/getOrganisation');
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
