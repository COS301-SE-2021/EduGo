import 'package:edugo_web_app/src/Pages/EduGo.dart';

class InviteStudentsController extends MomentumController<InviteStudentsModel> {
  @override
  InviteStudentsModel init() {
    return InviteStudentsModel(this, emails: []);
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
