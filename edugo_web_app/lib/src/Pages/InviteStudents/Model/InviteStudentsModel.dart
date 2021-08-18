import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/InviteStudents/View/Widgets/InviteStudentsWidgets.dart';
import 'package:edugo_web_app/src/Pages/Subjects/Model/Data/Subject.dart';

class InviteStudentsModel extends MomentumModel<InviteStudentsController> {
  final String currentEmailInput;
  final List<String> emails;

  final String subjectId;
  final String subjectName;

  InviteStudentsModel(InviteStudentsController controller,
      {this.currentEmailInput, this.emails, this.subjectId, this.subjectName})
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
      getEmailView();
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
    getEmailView();
  }

  List<Widget> getEmailView() {
    List<Widget> inviteEmailCards = [];
    int id = 0;
    emails.forEach(
      (email) {
        inviteEmailCards.add(StudentsEmailCard(
          emailId: id,
          emailValue: email,
        ));
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
  void update({currentEmailInput, emails, subjectId, subjectName}) {
    InviteStudentsModel(controller,
            currentEmailInput: currentEmailInput ?? this.currentEmailInput,
            emails: emails ?? this.emails,
            subjectId: subjectId ?? this.subjectId,
            subjectName: subjectName ?? this.subjectName)
        .updateMomentum();
  }
}
