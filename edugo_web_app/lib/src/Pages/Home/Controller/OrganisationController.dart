import 'package:edugo_web_app/src/Pages/EduGo.dart';

class OrganisationController extends MomentumController<OrganisationModel> {
  @override
  OrganisationModel init() {
    return OrganisationModel(
      this,
    );
  }

  void inputName(String organisationName) {
    model.setOrganisationName(organisationName);
  }

  void inputEmail(String description) {
    model.setOrganisationEmail(description);
  }

  void inputPhoneNumber(String phoneNumber) {
    model.setOrganisationPhoneNumber(phoneNumber);
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

  Future<void> createOrganisation(context) async {
    var url = Uri.parse(
        'http://localhost:8080/http://localhost:8080/organisation/createOrganisation');
    await post(url, headers: {
      'contentType': 'application/json',
    }, body: {
      "organisation_name": model.getOrganisationName(),
      "organisation_email": model.getOrganisationEmail(),
      "organisation_phone": model.getOrganisationPhoneNumber(),
      "password": model.getAdminPassword(),
      "user_firstName": model.getAdminFirstName(),
      "user_lastName": model.getAdminLastName(),
      "user_email": model.getAdminEmail(),
      "username": model.getAdminUserName()
    }).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> _organissation = jsonDecode(response.body);
        String returnedOrganisationId = _organissation['organisation_id'];
        Momentum.controller<SessionController>(context)
            .createOrganisationRedirect(
                userName: model.getAdminUserName(),
                password: model.getAdminPassword(),
                organisationId: returnedOrganisationId);
        if (Momentum.controller<SessionController>(context).getToken() !=
                null &&
            Momentum.controller<SessionController>(context).getToken() != '')
          MomentumRouter.goto(context, SubjectsView);
        return;
      }
    });
  }
}
