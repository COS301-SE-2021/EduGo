import 'package:edugo_web_app/src/Pages/EduGo.dart';

class InviteEducatorsController
    extends MomentumController<InviteEducatorsModel> {
  @override
  InviteEducatorsModel init() {
    return InviteEducatorsModel(this, emails: [], inviteResponse: "init");
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

  Future<String> sendInvitations(context) async {
    model.update(inviteResponse: "");
    var url = Uri.parse(EduGoHttpModule().getBaseUrl() + '/user/addEducators');
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
    ).then(
      (response) {
        if (response.statusCode == 200) {
          model.update(inviteResponse: "Invitations sent");
          model.update(emails: <String>[]);
          return "Invitations sent";
        }
        model.update(inviteResponse: "Invitations not sent");
        print(response.body);
        return "Invitations not sent";
      },
    );
    return model.inviteResponse;
  }
}
