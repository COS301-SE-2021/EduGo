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

  void setOrganisationId(String organisationId) {
    model.setOrganisationId(organisationId);
  }

  String startSession(String token, String organisationId) {
    if (token != null &&
        organisationId != null &&
        token != "" &&
        organisationId != "") {
      setToken(token);
      setOrganisationId(organisationId);
      return "Session Started";
    } else
      return "Session Start Failed";
  }
}
