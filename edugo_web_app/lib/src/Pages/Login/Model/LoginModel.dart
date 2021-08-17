import 'package:edugo_web_app/src/Pages/EduGo.dart';

class LoginModel extends MomentumModel<LoginController> {
  final String token;
  final String loginUserName;
  final String loginPassword;

  LoginModel(LoginController controller,
      {this.token, this.loginPassword, this.loginUserName})
      : super(controller);

  void setToken(String token) {
    update(token: token);
  }

  void setLoginUserName(String name) {
    update(loginUserName: name);
  }

  void setLoginPassword(String password) {
    update(loginPassword: password);
  }

  String getToken() {
    return token;
  }

  String getLoginUserName() {
    return loginUserName;
  }

  String getLoginPassword() {
    return loginPassword;
  }

  @override
  void update({
    token,
    loginUserName,
    loginPassword,
  }) {
    LoginModel(
      controller,
      token: token ?? this.token,
      loginUserName: loginUserName ?? this.loginUserName,
      loginPassword: loginPassword ?? this.loginPassword,
    ).updateMomentum();
  }
}
