import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:http/http.dart' as http;

class VerificationController extends MomentumController<VerificationModel> {
  @override
  VerificationModel init() {
    return VerificationModel(
      this,
    );
  }

  void setVerificationEmail(String email) {
    model.update(verificationEmail: email);
  }

  void setVerificationCode(String code) {
    model.update(verificationCode: code);
  }

  void resetErrorString() {
    model.update(errorString: null);
  }

  void setPassword(String password) {
    model.update(password: password);
  }

  void setFirstName(String firstName) {
    model.update(firstName: firstName);
  }

  void setLastName(String lastName) {
    model.update(lastName: lastName);
  }

  void setEmail(String email) {
    model.update(email: email);
  }

  void setUserName(String userName) {
    model.update(userName: userName);
  }

  Future<String> verifyUser() async {
    var url =
        Uri.parse(EduGoHttpModule().getBaseUrl() + "/auth/verifyInvitation");
    await http
        .post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "email": model.verificationEmail,
          "verificationCode": model.verificationCode
        },
      ),
    )
        .then(
      (response) {
        if (response.statusCode == 200) {
          model.update(errorString: "Verified");
          return;
        } else {
          model.update(errorString: "Invalid Credentials");
          return;
        }
      },
    );
    return model.errorString;
  }

  Future<String> registerUser() async {
    var url = Uri.parse(EduGoHttpModule().getBaseUrl() + "/auth/register");
    await http
        .post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "password": model.password,
          "user_firstName": model.firstName,
          "user_lastName": model.lastName,
          "user_email": model.email,
          "username": model.userName
        },
      ),
    )
        .then(
      (response) {
        if (response.statusCode == 200) {
          model.update(errorString: "User Created");
          return;
        } else if (response.statusCode == 404) {
          model.update(errorString: "User Not Invited");
          return;
        } else if (response.statusCode == 400) {
          model.update(errorString: "User Already Exists");
          return;
        }
      },
    );
    return model.errorString;
  }

  Future<String> loginUser({
    context,
  }) async {
    var url = Uri.parse(EduGoHttpModule().getBaseUrl() + "/auth/login");
    await http
        .post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "username": model.userName,
          "password": model.password
        },
      ),
    )
        .then(
      (response) {
        Map<String, dynamic> _user = jsonDecode(response.body);
        if (response.statusCode == 200) {
          String bearerToken = _user['token'];
          Momentum.controller<AdminController>(context).setToken(bearerToken);
          Momentum.controller<AdminController>(context)
              .setUserName(model.userName);
          Momentum.controller<AdminController>(context)
              .getOrganisationId(context);
          model.update(errorString: "Logged In");
          return;
        } else {
          model.update(errorString: "Invalid Credentials");
          return;
        }
      },
    );
    return model.errorString;
  }
}
