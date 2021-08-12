import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewBoundOrganisationController
    extends MomentumController<ViewBoundOrganisationModel> {
  @override
  ViewBoundOrganisationModel init() {
    return ViewBoundOrganisationModel(
      this,
    );
  }

  void inputName(String organisationName) {
    model.setViewBoundOrganisationName(organisationName);
  }

  void inputEmail(String description) {
    model.setViewBoundOrganisationEmail(description);
  }

  void inputPhoneNumber(String phoneNumber) {
    model.setViewBoundOrganisationPhoneNumber(phoneNumber);
  }

  void inputAdminFirstName(String firstName) {
    model.setAdminFirstName(firstName);
  }

  void inputAdminLastName(String lastName) {
    model.setAdminLastName(lastName);
  }

  void inputAdminEmail(String adminEmail) {
    model.setAdminEmail(adminEmail);
  }

  void inputAdminPassword(String adminPassword) {
    model.setAdminPassword(adminPassword);
  }

  void inputAdminConfirmPassword(String adminConfirmPassword) {
    model.setAdminConfirmPassword(adminConfirmPassword);
  }

  void inputAdminUserName(String adminUserName) {
    model.setAdminUserName(adminUserName);
  }

  Future createOrganisation(context) {
    MomentumRouter.goto(context, SubjectsView);
  }
}
