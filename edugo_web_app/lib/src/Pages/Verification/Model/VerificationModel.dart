import 'package:edugo_web_app/src/Pages/EduGo.dart';

class VerificationModel extends MomentumModel<VerificationController> {
  final String verificationCode;
  final String verificationEmail;
  final String errorString;
  final String password;
  final String firstName;
  final String lastName;
  final String email;
  final String userName;

  VerificationModel(VerificationController controller,
      {this.verificationCode,
      this.verificationEmail,
      this.errorString,
      this.password,
      this.firstName,
      this.lastName,
      this.email,
      this.userName})
      : super(controller);

  @override
  void update(
      {verificationCode,
      verificationEmail,
      errorString,
      password,
      firstName,
      lastName,
      email,
      userName}) {
    VerificationModel(controller,
            verificationCode: verificationCode ?? this.verificationCode,
            verificationEmail: verificationEmail ?? this.verificationEmail,
            errorString: errorString ?? this.errorString,
            password: password ?? this.password,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            email: email ?? this.email,
            userName: userName ?? this.userName)
        .updateMomentum();
  }
}
