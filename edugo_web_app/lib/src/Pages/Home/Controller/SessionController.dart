import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:http/http.dart' as http;

class SessionController extends MomentumController<SessionModel> {
  @override
  SessionModel init() {
    return SessionModel(
      this,
    );
  }

  void setToken(String token) {
    model.setToken(token);
  }

  String getToken() {
    return model.token;
  }

  void setLoginUserName(String name) {
    model.setLoginUserName(name);
  }

  void setLoginPassword(String password) {
    model.setLoginPassword(password);
  }

  String getLoginuserName() {
    return model.getLoginUserName();
  }

  String getLoginPassword() {
    return model.getLoginPassword();
  }

  void setOrganisationId(String organisationId) {
    model.setOrganisationId(organisationId);
  }

  Future<String> loginUser(
      {context, String organisationId, GlobalKey<FormState> formkey}) async {
    String loginResponse;

    if (model.getLoginUserName() != null &&
        model.getLoginPassword() != null &&
        model.getLoginUserName() != "" &&
        model.getLoginPassword() != "") {
      if (organisationId != null && organisationId != "") {
        setOrganisationId(organisationId);
      }
      var url = Uri.parse('http://43e6071f3a8e.ngrok.io/auth/login');
      await http
          .post(url,
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode(<String, String>{
                "username": model.getLoginUserName(),
                "password": model.getLoginPassword()
              }))
          .then((response) {
        Map<String, dynamic> _user = jsonDecode(response.body);
        if (_user['name'] == "UnauthorizedError") {
          formkey.currentState.validate();

          return;
        }
        if (response.statusCode == 200) {
          String bearerToken = _user['token'];
          setToken(bearerToken);
          Momentum.controller<CurrentOrganisationController>(context)
              .getOrganisationEducators();
          Momentum.controller<CurrentOrganisationController>(context)
              .getEducatorSubjects(context);
          MomentumRouter.goto(context, SubjectsView);
          loginResponse = "Session Started";
          return;
        }
        loginResponse = "Session Start Failed";
      });
    } else
      loginResponse = "Session Start Failed";
    return loginResponse;
  }

  Future<String> createOrganisationRedirect(
      {context,
      String userName,
      String password,
      String organisationId}) async {
    String loginResponse;
    if (userName != null &&
        password != null &&
        userName != "" &&
        password != "") {
      if (organisationId != null && organisationId != "") {
        setOrganisationId(organisationId);
      }
      var url = Uri.parse('http://localhost:8080/auth/login');
      await post(url,
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode(
                  <String, String>{"username": userName, 'password': password}))
          .then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> _user = jsonDecode(response.body);
          String bearerToken = _user['token'];
          setToken(bearerToken);
          MomentumRouter.goto(context, SubjectsView);
          loginResponse = "Session Started";
          return;
        }
        loginResponse = "Session Start Failed";
      });
    }
    loginResponse = "Session Start Failed";
    return loginResponse;
  }
}
