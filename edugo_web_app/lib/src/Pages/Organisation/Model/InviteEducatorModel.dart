import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Organisation/View/Widgets/InviteEmailCard.dart';

class InviteEducatorModel extends MomentumModel<InviteEducatorController> {
  final String currentEmailInput;
  final List<String> emails;

  InviteEducatorModel(InviteEducatorController controller,
      {this.currentEmailInput, this.emails})
      : super(controller);

  void inputEmail(String email) {
    update(currentEmailInput: email);
  }

  void addEmail() {
    if (currentEmailInput != null) {
      List<String> tempEmails = emails;
      tempEmails.add(currentEmailInput);
      update(emails: tempEmails);
      getEmailView();
    }
  }

  void removeEmail(int emailId) {
    List<String> tempEmails = emails;
    tempEmails.removeAt(emailId);
    update(emails: tempEmails);
    getEmailView();
  }

  List<Widget> getEmailView() {
    List<Widget> inviteEmailCards = [];
    int id = 0;
    emails.forEach(
      (email) {
        inviteEmailCards.add(InviteEmailCard(emailId: id, emailValue: email));
        inviteEmailCards.add(
          SizedBox(
            height: 20,
          ),
        );
        id++;
      },
    );

    return inviteEmailCards;
  }

  String getEmailsJSON() {
    String jSON = "{" + emails[0] + ",";
    emails.forEach(
      (email) {
        jSON += email + ",";
      },
    );
    jSON += "}";
    return jSON;
  }

  @override
  void update({currentEmailInput, emails}) {
    InviteEducatorModel(
      controller,
      currentEmailInput: currentEmailInput ?? this.currentEmailInput,
      emails: emails ?? this.emails,
    ).updateMomentum();
  }
}
