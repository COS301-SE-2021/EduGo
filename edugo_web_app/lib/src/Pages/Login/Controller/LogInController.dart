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

  void resetErrorString() {
    model.update(errorString: null);
  }

  Future<String> loginUser({
    context,
  }) async {
    if (model.loginPassword != null &&
        model.loginUserName != null &&
        model.loginUserName != "" &&
        model.loginPassword != "") {
      var url = Uri.parse(EduGoHttpModule().getBaseUrl() + "/auth/login");
      await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          <String, String>{
            "username": model.loginUserName,
            "password": model.loginPassword
          },
        ),
      )
          .then(
        (response) {
          Map<String, dynamic> _user = jsonDecode(response.body);

          if (response.statusCode == 200) {
            String bearerToken = _user['token'];
            Momentum.controller<AdminController>(context).setToken(bearerToken);
            Momentum.controller<AdminController>(context)
                .setUserName(model.loginUserName);
            MomentumRouter.goto(context, AdminView);
            Momentum.controller<AdminController>(context)
                .getOrganisationId(context);

            model.update(errorString: "Logged In");
            return;
          } else {
            model.update(errorString: "Invalid Credentials");
            return;
          }
        },
      );
      return model.errorString;
    }
    return model.errorString;
  }
}
