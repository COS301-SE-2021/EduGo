import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Subjects/Model/Data/Subject.dart';

class InviteStudentsController extends MomentumController<InviteStudentsModel> {
  @override
  InviteStudentsModel init() {
    return InviteStudentsModel(this, emails: [], inviteResponse: "init");
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

  void inputSubjectName(String name) {
    model.inputSubjectName(name);
  }

  List<String> getSubjectsString(List<Subject> subjects) {
    return model.getSubjectsString(subjects);
  }

  List<Widget> getEmailView() {
    return model.getEmailView();
  }

  Future<String> sendInvitations(context) async {
    model.update(inviteResponse: "");
    var url = Uri.parse(
        EduGoHttpModule().getBaseUrl() + '/user/addStudentsToSubject');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
      body: jsonEncode(
        <String, dynamic>{
          "subject_id": Momentum.controller<AdminController>(context)
              .getCurrentSubjectId(),
          "students": model.emails
        },
      ),
    ).then((response) {
      if (response.statusCode == 200) {
        model.update(inviteResponse: "Invitations sent");
        model.update(emails: <String>[]);
        return "Invitations sent";
      }
      model.update(inviteResponse: "Invitations not sent");
      return "Invitations not sent";
    });
    return model.inviteResponse;
  }
}
