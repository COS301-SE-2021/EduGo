import 'package:edugo_web_app/src/Pages/EduGo.dart';

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

  Future<String> loginUser({String organisationId}) async {
    String loginResponse;
    if (model.getLoginUserName() != null &&
        model.getLoginPassword() != null &&
        model.getLoginUserName() != "" &&
        model.getLoginPassword() != "") {
      if (organisationId != null && organisationId != "") {
        setOrganisationId(organisationId);
      }
      var url = Uri.parse('http://localhost:8080/auth/login');
      await post(url, headers: {
        'contentType': 'application/json',
      }, body: {
        "username": model.getLoginUserName(),
        'password': model.getLoginPassword()
      }).then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> _user = jsonDecode(response.body);
          String bearerToken = _user['token'];
          setToken(bearerToken);
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
      {String userName, String password, String organisationId}) async {
    String loginResponse;
    if (userName != null &&
        password != null &&
        userName != "" &&
        password != "") {
      if (organisationId != null && organisationId != "") {
        setOrganisationId(organisationId);
      }
      var url = Uri.parse('http://localhost:8080/auth/login');
      await post(url, headers: {
        'contentType': 'application/json',
      }, body: {
        "username": userName,
        'password': password
      }).then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> _user = jsonDecode(response.body);
          String bearerToken = _user['token'];
          setToken(bearerToken);
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
