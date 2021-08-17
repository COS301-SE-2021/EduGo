import 'package:edugo_web_app/src/Pages/EduGo.dart';

class SessionModel extends MomentumModel<SessionController> {
  final String token;
  final String loginUserName;
  final String loginPassword;

  SessionModel(SessionController controller,
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
    SessionModel(
      controller,
      token: token ?? this.token,
      loginUserName: loginUserName ?? this.loginUserName,
      loginPassword: loginPassword ?? this.loginPassword,
    ).updateMomentum();
  }
}
