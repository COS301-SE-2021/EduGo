import 'package:edugo_web_app/src/Pages/EduGo.dart';

class SessionModel extends MomentumModel<SessionController> {
  final String organisationId;
  final String token;

  SessionModel(SessionController controller, {this.organisationId, this.token})
      : super(controller);

  void setOrganisationId(String organisationId) {
    update(organisationId: organisationId);
  }

  void setToken(String token) {
    update(token: token);
  }

  String getOrganisationId() {
    return organisationId;
  }

  String getToken() {
    return token;
  }

  @override
  void update({organisationId, token}) {
    SessionModel(
      controller,
      organisationId: organisationId ?? this.organisationId,
      token: token ?? this.token,
    ).updateMomentum();
  }
}
