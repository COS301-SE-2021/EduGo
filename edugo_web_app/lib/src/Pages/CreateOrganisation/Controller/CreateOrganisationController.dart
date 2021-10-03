import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:http/http.dart' as http;

class CreateOrganisationController
    extends MomentumController<CreateOrganisationModel> {
  @override
  CreateOrganisationModel init() {
    return CreateOrganisationModel(
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

  String getAdminPassword() {
    return model.getAdminPassword();
  }

  String getAdminUserName() {
    return model.getAdminUserName();
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

  Future<String> createOrganisation() async {
    var url = Uri.parse(
        EduGoHttpModule().getBaseUrl() + '/organisation/createOrganisation');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "organisation_name": model.getOrganisationName(),
          "organisation_email": model.getOrganisationEmail(),
          "organisation_phone": model.getOrganisationPhoneNumber(),
          "password": model.getAdminPassword(),
          "user_firstName": model.getAdminFirstName(),
          "user_lastName": model.getAdminLastName(),
          "user_email": model.getAdminEmail(),
          "username": model.getAdminUserName()
        },
      ),
    ).then(
      (response) async {
        if (response.statusCode == 200) {
          model.update(errorString: "Organisation Created");
        } else {
          model.update(errorString: "Organisation Not Created");
        }
      },
    );
    return model.errorString;
  }

  Future<void> loginUser(
    context,
  ) async {
    if (model.adminPassword != null &&
        model.adminUserName != null &&
        model.adminUserName != "" &&
        model.adminPassword != "") {
      var url = Uri.parse(EduGoHttpModule().getBaseUrl() + '/auth/login');
      await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          <String, String>{
            "username": model.adminUserName,
            "password": model.adminPassword
          },
        ),
      )
          .then(
        (response) {
          if (response.statusCode == 200) {
            Map<String, dynamic> _user = jsonDecode(response.body);
            String bearerToken = _user['token'];
            Momentum.controller<AdminController>(context).setToken(bearerToken);
            Momentum.controller<AdminController>(context)
                .setUserName(model.adminUserName);
            MomentumRouter.goto(context, AdminView);
            return;
          }
        },
      );
    }
  }
}
