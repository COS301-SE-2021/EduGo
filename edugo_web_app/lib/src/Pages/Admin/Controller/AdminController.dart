import 'package:edugo_web_app/src/Pages/Admin/Model/Data/User.dart';
import 'package:edugo_web_app/src/Pages/Admin/Model/Data/Users.dart';
import 'package:edugo_web_app/src/Pages/Admin/View/Widgets/AdminWidgets.dart';
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

  String getCurrentSubjectImage() {
    return model.currentSubjectImageLink;
  }

  void updateEducatorsView({context}) {
    List<Widget> educatorsWidgets = [];
    bool educatorCheck = false;
    model.educators.forEach(
      (educator) {
        if (educator.getName() == model.userName &&
            educator.getAdmin() == false) {
          model.update(currentUser: educator);
          educatorCheck = true;
          MomentumRouter.goto(context, SubjectsView);
          return;
        }
        if (educator.getAdmin() == true &&
            educator.getName() == model.userName) {
          model.update(currentUser: educator);
        } else {
          educatorsWidgets.add(
            new EducatorCard(
              name: educator.getName(),
              admin: educator.getAdmin(),
            ),
          );
          educatorsWidgets.add(
            SizedBox(
              height: 20,
            ),
          );
        }
      },
    );
    model.update(educatorCards: educatorsWidgets);
  }

  void setCurrentSubjectId(int id) {
    model.update(currentSubjectId: id);
  }

  void setUserName(String name) {
    model.update(userName: name);
  }

  void setCurrentLessonId(int id) {
    model.update(currentLessonId: id);
  }

  void setToken(String token) {
    model.update(token: token);
  }

  void setVirtualEntityViewerModelLink(String link) {
    model.update(virtualEntityViewerModelLink: link);
  }

  void setOrganisationId(int id) {
    model.update(organisationId: id);
  }

  void setCurrentSubjectImageLink(String link) {
    model.update(currentSubjectImageLink: link);
  }

  void setOrganisationName(String name) {
    model.update(organisationName: name);
  }

  String getToken() {
    return model.token;
  }

  String getVirtualEntityViewerModelLink() {
    return model.virtualEntityViewerModelLink;
  }

  int getCurrentSubjectId() {
    return model.currentSubjectId;
  }

  int getCurrentLessonId() {
    return model.currentLessonId;
  }

  void updateEducators(List<User> educators) {
    model.update(educators: educators);
  }

  int getId() {
    return model.organisationId;
  }

  Future<void> makeEducatorAdmin(String username) async {
    model.update(adminLoadController: false);
    // * Send make admin request
    var url =
        Uri.parse(EduGoHttpModule().getBaseUrl() + '/user/setUserToAdmin');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': getToken()
      },
      body: jsonEncode(
        <String, String>{
          "username": username,
        },
      ),
    ).then(
      (response) async {
        if (response.statusCode == 200) {
          await getOrganisationEducators().then(
            (value) {
              model.update(adminLoadController: true);
            },
          );
          return;
        }
      },
    );
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
    ).then(
      (response) async {
        Map<String, dynamic> _user = jsonDecode(response.body);
        if (response.statusCode == 200) {
          int organisationId = _user['organisation_id'];
          setOrganisationId(organisationId);
          await getOrganisationName(organisationId).then(
            (value) {
              Momentum.controller<AdminController>(context)
                  .getOrganisationEducators(context: context);
            },
          );
        }
      },
    );
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
        .then(
      (response) {
        Map<String, dynamic> _organisation = jsonDecode(response.body);
        if (response.statusCode == 200) {
          String organisationName = _organisation['organisation_name'];
          setOrganisationName(organisationName);
        }
      },
    );
  }

  Future<void> revokeEducatorAdmin(String username) async {
    model.update(adminLoadController: false);
    // * Send make admin request
    var url =
        Uri.parse(EduGoHttpModule().getBaseUrl() + '/user/revokeUserFromAdmin');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': getToken()
      },
      body: jsonEncode(
        <String, String>{
          "username": username,
        },
      ),
    ).then(
      (response) async {
        if (response.statusCode == 200) {
          await getOrganisationEducators().then(
            (value) {
              model.update(adminLoadController: true);
            },
          );
          return;
        }
      },
    );
  }

  Future<void> getOrganisationEducators({context}) async {
    var url = Uri.parse(
        EduGoHttpModule().getBaseUrl() + '/organisation/getOrganisation');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': getToken()
      },
      body: jsonEncode(
        <String, int>{
          "id": model.organisationId,
        },
      ),
    ).then(
      (response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> _organisation = jsonDecode(response.body);
          updateEducators(Users.fromJson(_organisation).users);
          updateEducatorsView(context: context);
          return;
        }
      },
    );
  }
}
