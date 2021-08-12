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

  void inputAdminUserName(String adminUserName) {
    model.setAdminUserName(adminUserName);
  }

  Future createOrganisation(context) async {
    var url = Uri.parse(
        'http://localhost:8080/http://localhost:8080/organisation/createOrganisation');
    await post(url, headers: {
      'contentType': 'application/json',
    }, body: {
      "organisation_name": model.getViewBoundOrganisationName(),
      "organisation_email": model.getViewBoundOrganisationEmail(),
      "organisation_phone": model.getViewBoundOrganisationPhoneNumber(),
      "password": model.getAdminPassword(),
      "user_firstName": model.getAdminFirstName(),
      "user_lastName": model.getAdminLastName(),
      "user_email": model.getAdminEmail(),
      "username": model.getAdminUserName()
    }).then((value) => {MomentumRouter.goto(context, SubjectsView)});
  }
}
