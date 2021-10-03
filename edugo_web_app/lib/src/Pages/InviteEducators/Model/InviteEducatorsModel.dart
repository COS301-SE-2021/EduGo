import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/InviteEducators/View/Widgets/InviteEducatorsWidgets.dart';

class InviteEducatorsModel extends MomentumModel<InviteEducatorsController> {
  final String currentEmailInput;
  final List<String> emails;
  final String inviteResponse;
  final List<Widget> emailCards;

  InviteEducatorsModel(InviteEducatorsController controller,
      {this.currentEmailInput,
      this.emails,
      this.emailCards,
      this.inviteResponse})
      : super(controller);

  void inputEmail(String email) {
    update(currentEmailInput: email);
  }

  void addEmail() {
    if (currentEmailInput != null) {
      List<String> tempEmails = emails;
      tempEmails.add(currentEmailInput);
      update(emails: tempEmails);
      update(emailCards: getEmailView());
    }
  }

  void removeEmail(int emailId) {
    List<String> tempEmails = emails;
    tempEmails.removeAt(emailId);
    update(emails: tempEmails);
    List<Widget> tempWidgets = emailCards;
    tempWidgets.removeAt(emailId);
    update(emailCards: getEmailView());
  }

  List<Widget> getEmailView() {
    List<Widget> inviteEmailCards = [];
    int id = 0;
    emails.forEach(
      (email) {
        inviteEmailCards
            .add(EducatorsEmailCard(emailId: id, emailValue: email));
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
  void update({currentEmailInput, emails, inviteResponse, emailCards}) {
    InviteEducatorsModel(
      controller,
      currentEmailInput: currentEmailInput ?? this.currentEmailInput,
      emails: emails ?? this.emails,
      inviteResponse: inviteResponse ?? this.inviteResponse,
      emailCards: emailCards ?? this.emailCards,
    ).updateMomentum();
  }
}
