import 'package:edugo_web_app/src/Pages/EduGo.dart';

class InviteEducatorsController
    extends MomentumController<InviteEducatorsModel> {
  @override
  InviteEducatorsModel init() {
    return InviteEducatorsModel(this, emails: []);
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

  Future<void> sendInvitations(context) async {
    var url = Uri.parse('http://34.65.226.152:8080/user/addEducators');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
      body: jsonEncode(
        <String, dynamic>{"educators": model.emails},
      ),
    ).then((response) {
      if (response.statusCode == 200) {
        MomentumRouter.goto(context, AdminView);
        return;
      }
    });
  }
}
