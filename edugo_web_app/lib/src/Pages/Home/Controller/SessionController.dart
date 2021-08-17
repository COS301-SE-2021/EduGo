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

  Future<void> loginUser(
      {context, String organisationId, GlobalKey<FormState> formkey}) async {
    if (model.getLoginUserName() != null &&
        model.getLoginPassword() != null &&
        model.getLoginUserName() != "" &&
        model.getLoginPassword() != "") {
      var url = Uri.parse('http://34.65.226.152:8080/auth/login');
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
          MomentumRouter.goto(context, OrganisationDashboardView);
          return;
        }
      });
    }
  }
}
