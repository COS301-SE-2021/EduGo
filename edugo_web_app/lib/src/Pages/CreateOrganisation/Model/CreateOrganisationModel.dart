import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateOrganisationModel
    extends MomentumModel<CreateOrganisationController> {
  final String organisationName;
  final String organisationEmail;
  final String phoneNumber;
  final String adminFirstName;
  final String adminLastName;
  final String adminEmail;
  final String adminUserName;
  final String adminPassword;

  CreateOrganisationModel(CreateOrganisationController controller,
      {this.organisationName,
      this.organisationEmail,
      this.phoneNumber,
      this.adminEmail,
      this.adminFirstName,
      this.adminLastName,
      this.adminPassword,
      this.adminUserName})
      : super(controller);

  void setOrganisationName(String organisationName) {
    update(organisationName: organisationName);
  }

  void setOrganisationEmail(String organisationEmail) {
    update(organisationEmail: organisationEmail);
  }

  void setOrganisationPhoneNumber(String viewBoundOrganisationPhoneNumber) {
    update(phoneNumber: viewBoundOrganisationPhoneNumber);
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

  String getOrganisationName() {
    return organisationName;
  }

  String getOrganisationEmail() {
    return organisationEmail;
  }

  String getOrganisationPhoneNumber() {
    return phoneNumber;
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
      adminEmail,
      adminFirstName,
      adminLastName,
      adminPassword,
      adminUserName}) {
    CreateOrganisationModel(
      controller,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      organisationName: organisationName ?? this.organisationName,
      organisationEmail: organisationEmail ?? this.organisationEmail,
      adminEmail: adminEmail ?? this.adminEmail,
      adminFirstName: adminFirstName ?? this.adminFirstName,
      adminLastName: adminLastName ?? this.adminLastName,
      adminPassword: adminPassword ?? this.adminPassword,
      adminUserName: adminUserName ?? this.adminUserName,
    ).updateMomentum();
  }
}
