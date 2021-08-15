import 'package:edugo_web_app/src/Pages/EduGo.dart';

class InviteStudentController extends MomentumController<InviteStudentModel> {
  @override
  InviteStudentModel init() {
    return InviteStudentModel(this, emails: []);
  }

  void inputEmail(String email) {
    model.inputEmail(email);
  }

  void addEmail() {
    model.addEmail();
  }

  void removeEmail(int emailId) {
    model.removeEmail(emailId);
  }

  List<Widget> getEmailView() {
    return model.getEmailView();
  }
}
