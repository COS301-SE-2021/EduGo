import 'package:edugo_web_app/src/Pages/EduGo.dart';

class LoginModel extends MomentumModel<LogInController> {
  final String loginUserName;
  final String loginPassword;

  LoginModel(LogInController controller,
      {this.loginPassword, this.loginUserName})
      : super(controller);

  void setLoginUserName(String name) {
    update(loginUserName: name);
  }

  void setLoginPassword(String password) {
    update(loginPassword: password);
  }

  @override
  void update({
    loginUserName,
    loginPassword,
  }) {
    LoginModel(
      controller,
      loginUserName: loginUserName ?? this.loginUserName,
      loginPassword: loginPassword ?? this.loginPassword,
    ).updateMomentum();
  }
}
