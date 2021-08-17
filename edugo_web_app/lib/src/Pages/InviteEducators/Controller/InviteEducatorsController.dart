import 'package:edugo_web_app/src/Pages/EduGo.dart';

class InviteEducatorsController
    extends MomentumController<InviteEducatorsModel> {
  @override
  InviteEducatorsModel init() {
    return InviteEducatorModel(this, emails: []);
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
