import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:http/http.dart' as http;

class LogInController extends MomentumController<LoginModel> {
  @override
  LoginModel init() {
    return LoginModel(
      this,
    );
  }

  void setLoginUserName(String name) {
    model.setLoginUserName(name);
  }

  void setLoginPassword(String password) {
    model.setLoginPassword(password);
  }

  Future<void> loginUser({context, GlobalKey<FormState> formkey}) async {
    if (model.loginPassword != null &&
        model.loginUserName != null &&
        model.loginUserName != "" &&
        model.loginPassword != "") {
      var url = Uri.parse('http://34.65.226.152:8080/auth/login');
      await http
          .post(url,
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode(<String, String>{
                "username": model.loginUserName,
                "password": model.loginPassword
              }))
          .then((response) {
        Map<String, dynamic> _user = jsonDecode(response.body);

        if (_user['name'] == "UnauthorizedError") {
          formkey.currentState.validate();

          return;
        }

        if (response.statusCode == 200) {
          String bearerToken = _user['token'];
          Momentum.controller<AdminController>(context).setToken(bearerToken);
          MomentumRouter.goto(context, AdminView);
          return;
        }
      });
    } else
      formkey.currentState.validate();
  }
}
