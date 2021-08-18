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
    var url =
        Uri.parse('http://34.65.226.152:8080/organisation/createOrganisation');
    await post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "organisation_name": model.getOrganisationName(),
          "organisation_email": model.getOrganisationEmail(),
          "organisation_phone": model.getOrganisationPhoneNumber(),
          "password": model.getAdminPassword(),
          "user_firstName": model.getAdminFirstName(),
          "user_lastName": model.getAdminLastName(),
          "user_email": model.getAdminEmail(),
          "username": model.getAdminUserName()
        })).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> _organisation = jsonDecode(response.body);
        Momentum.controller<AdminController>(context)
            .getOrganisationName(_organisation['organisation_id']);
        loginAdmin(context);
        return;
      }
    });
  }

  Future<void> loginAdmin(context) async {
    var url = Uri.parse('http://34.65.226.152:8080/auth/login');
    await http
        .post(url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, String>{
              "username": model.getAdminUserName(),
              "password": model.getAdminPassword()
            }))
        .then((response) {
      print(response.body);
      Map<String, dynamic> _user = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String bearerToken = _user['token'];
        Momentum.controller<AdminController>(context).setToken(bearerToken);
        MomentumRouter.goto(context, AdminView);
        return;
      }
    });
  }
}
