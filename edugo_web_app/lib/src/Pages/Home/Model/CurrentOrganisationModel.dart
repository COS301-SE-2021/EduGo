import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CurrentOrganisationModel
    extends MomentumModel<CurrentOrganisationController> {
  final String organisationName;
  final String organisationEmail;
  final String organisationId;
  final String phoneNumber;
  final List<Subject> subjects;
  CurrentOrganisationModel(CurrentOrganisationController controller,
      {this.organisationName,
      this.organisationEmail,
      this.organisationId,
      this.phoneNumber,
      this.subjects})
      : super(controller);

  String getOrganisationName() {
    return organisationName;
  }

  String getOrganisationId() {
    return organisationId;
  }

  String getOrganisationEmail() {
    return organisationEmail;
  }

  String getOrganisationPhoneNumber() {
    return phoneNumber;
  }

  @override
  void update(
      {phoneNumber,
      organisationName,
      organisationEmail,
      organisationId,
      educatorViewOrStudentView,
      subjects}) {
    CurrentOrganisationModel(controller,
            organisationId: organisationId ?? this.organisationId,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            organisationName: organisationName ?? this.organisationName,
            organisationEmail: organisationEmail ?? this.organisationEmail,
            subjects: subjects ?? this.subjects)
        .updateMomentum();
  }
}
