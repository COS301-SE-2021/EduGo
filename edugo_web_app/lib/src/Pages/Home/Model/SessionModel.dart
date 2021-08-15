import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Home/Model/Data/User.dart';

class SessionModel extends MomentumModel<SessionController> {
  final String organisationId;
  final String token;
  final User currentUser;
  final String loginUserName;
  final String loginPassword;

  SessionModel(SessionController controller,
      {this.organisationId,
      this.token,
      this.currentUser,
      this.loginPassword,
      this.loginUserName})
      : super(controller);

  void setOrganisationId(String organisationId) {
    update(organisationId: organisationId);
  }

  void setToken(String token) {
    update(token: token);
  }

  void setCurrentUserName(String name) {
    User tempUser = currentUser;
    tempUser.setName(name);
    update(currentUser: tempUser);
  }

  void setAdmin(bool admin) {
    User tempUser = currentUser;
    tempUser.setAdmin(admin);
    update(currentUser: tempUser);
  }

  void setLoginUserName(String name) {
    update(loginUserName: name);
  }

  void setLoginPassword(String password) {
    update(loginPassword: password);
  }

  String getOrganisationId() {
    return organisationId;
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
  void update(
      {organisationId, token, currentUser, loginUserName, loginPassword}) {
    SessionModel(
      controller,
      organisationId: organisationId ?? this.organisationId,
      token: token ?? this.token,
      currentUser: currentUser ?? this.currentUser,
      loginUserName: loginUserName ?? this.loginUserName,
      loginPassword: loginPassword ?? this.loginPassword,
    ).updateMomentum();
  }
}
