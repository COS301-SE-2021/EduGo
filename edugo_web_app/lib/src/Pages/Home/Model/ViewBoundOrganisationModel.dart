import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewBoundOrganisationModel
    extends MomentumModel<ViewBoundOrganisationController> {
  final String organisationName;
  final String organisationEmail;
  final String phoneNumber;
  final String adminFirstName;
  final String adminLastName;
  final String adminEmail;
  final String adminUserName;
  final String adminPassword;
  final String adminConfirmPassword;

  ViewBoundOrganisationModel(ViewBoundOrganisationController controller,
      {this.organisationName,
      this.organisationEmail,
      this.phoneNumber,
      this.adminConfirmPassword,
      this.adminEmail,
      this.adminFirstName,
      this.adminLastName,
      this.adminPassword,
      this.adminUserName})
      : super(controller);

  void setViewBoundOrganisationName(String organisationName) {
    update(organisationName: organisationName);
  }

  void setViewBoundOrganisationEmail(String organisationEmail) {
    update(organisationEmail: organisationEmail);
  }

  void setViewBoundOrganisationPhoneNumber(
      String viewBoundOrganisationPhoneNumber) {
    update(phoneNumber: viewBoundOrganisationPhoneNumber);
  }

  void setAdminConfirmPassword(String adminConfirmPassword) {
    update(adminConfirmPassword: adminConfirmPassword);
  }

  void setAdminPassword(String adminPassword) {
    update(adminPassword: adminPassword);
  }

  void setAdminEmail(String adminEmail) {
    update(adminEmail: adminEmail);
  }

  void setAdminFirstName(String adminFirstName) {
    update(adminFirstName: adminFirstName);
  }

  void setAdminLastName(String adminLastName) {
    update(adminLastName: adminLastName);
  }

  void setAdminUserName(String adminUserName) {
    update(adminUserName: adminUserName);
  }

  String getViewBoundOrganisationName() {
    return organisationName;
  }

  String getViewBoundOrganisationEmail() {
    return organisationEmail;
  }

  String getViewBoundOrganisationPhoneNumber() {
    return phoneNumber;
  }

  String getAdminConfirmPassword() {
    return adminConfirmPassword;
  }

  String getAdminEmail() {
    return adminEmail;
  }

  String getAdminFirstName() {
    return adminFirstName;
  }

  String getAdminLastName() {
    return adminLastName;
  }

  String getAdminPassword() {
    return adminPassword;
  }

  String getAdminUserName() {
    return adminUserName;
  }

  @override
  void update(
      {phoneNumber,
      organisationName,
      organisationEmail,
      adminConfirmPassword,
      adminEmail,
      adminFirstName,
      adminLastName,
      adminPassword,
      adminUserName}) {
    ViewBoundOrganisationModel(
      controller,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      organisationName: organisationName ?? this.organisationName,
      organisationEmail: organisationEmail ?? this.organisationEmail,
      adminConfirmPassword: adminConfirmPassword ?? this.adminConfirmPassword,
      adminEmail: adminEmail ?? this.adminEmail,
      adminFirstName: adminFirstName ?? this.adminFirstName,
      adminLastName: adminLastName ?? this.adminLastName,
      adminPassword: adminLastName ?? this.adminLastName,
      adminUserName: adminUserName ?? this.adminUserName,
    ).updateMomentum();
  }
}
