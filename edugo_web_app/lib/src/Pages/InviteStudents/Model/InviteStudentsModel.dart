import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/InviteStudents/View/Widgets/InviteStudentsWidgets.dart';
import 'package:edugo_web_app/src/Pages/Subjects/Model/Data/Subject.dart';

class InviteStudentsModel extends MomentumModel<InviteStudentsController> {
  final String currentEmailInput;
  final String inviteResponse;
  final List<String> emails;
  final List<Widget> emailCards;

  final String subjectId;
  final String subjectName;

  InviteStudentsModel(InviteStudentsController controller,
      {this.currentEmailInput,
      this.emailCards,
      this.emails,
      this.inviteResponse,
      this.subjectId,
      this.subjectName})
      : super(controller);

  void inputEmail(String email) {
    update(currentEmailInput: email);
  }

  void inputSubjectName(String name) {
    update(subjectName: name);
  }

  void addEmail() {
    if (currentEmailInput != null) {
      List<String> tempEmails = emails;
      tempEmails.add(currentEmailInput);
      update(emails: tempEmails);
      update(emailCards: getEmailView());
    }
  }

  List<String> getSubjectsString(List<Subject> subjects) {
    List<String> subjectsString = [];
    subjects.forEach((subject) {
      subjectsString.add(subject.getSubjectTitle());
    });
    return subjectsString;
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
        inviteEmailCards.add(
          StudentsEmailCard(
            emailId: id,
            emailValue: email,
          ),
        );
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

  @override
  void update(
      {currentEmailInput,
      emails,
      subjectId,
      subjectName,
      inviteResponse,
      emailCards}) {
    InviteStudentsModel(controller,
            currentEmailInput: currentEmailInput ?? this.currentEmailInput,
            emails: emails ?? this.emails,
            subjectId: subjectId ?? this.subjectId,
            subjectName: subjectName ?? this.subjectName,
            inviteResponse: inviteResponse ?? this.inviteResponse,
            emailCards: emailCards ?? this.emailCards)
        .updateMomentum();
  }
}
