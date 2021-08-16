import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Home/Model/Data/User.dart';

class CurrentOrganisationModel
    extends MomentumModel<CurrentOrganisationController> {
  final String organisationName;
  final String organisationEmail;
  final String organisationId;
  final String phoneNumber;
  final List<Subject> subjects;
  final List<Widget> subjectsView;
  final List<Lesson> lessons;
  final List<Widget> lessonsView;
  final List<User> educators;
  final List<Widget> educatorsView;
  CurrentOrganisationModel(CurrentOrganisationController controller,
      {this.organisationName,
      this.subjectsView,
      this.organisationEmail,
      this.organisationId,
      this.phoneNumber,
      this.subjects,
      this.lessons,
      this.lessonsView,
      this.educatorsView,
      this.educators})
      : super(controller);

  String getOrganisationName() {
    return organisationName;
  }

  String getOrganisationId() {
    return organisationId;
  }

  String getOrganisationEmail() {
    return organisationEmail;
  }

  String getOrganisationPhoneNumber() {
    return phoneNumber;
  }

  void updateEducators(List<User> educators) {
    update(educators: educators);
  }

  void updateEducatorsAdmin(int id, bool admin) {
    int i = 0;
    List<User> tempEducators = educators;
    tempEducators.forEach((educator) {
      if (educator.id == id) {
        tempEducators[i].admin = admin;
        return;
      }
      i++;
    });
    update(educators: tempEducators);
  }

  void updateEducatorsView() {
    List<Widget> educatorsWidgets = [];
    //*make request to get organisation educators and map to User object

    educators.forEach((educator) {
      educatorsWidgets.add(new EducatorCard(
          name: educator.name, admin: educator.admin, id: educator.id));
      educatorsWidgets.add(SizedBox(
        height: 20,
      ));
    });
    update(educatorsView: educatorsWidgets);
  }

  void updateSubjectsView() {
    List<Widget> subjectsWidgets = [];
    subjects.forEach((subject) {
      subjectsWidgets.add(new SubjectCard(
          title: subject.getSubjectTitle(),
          grade: subject.getSubjectGrade(),
          imageLink: subject.getSubjectImageLink(),
          subjectId: subject.getSubjectId().toString()));
    });
    update(subjectsView: subjectsWidgets);
  }

  void updateLessonsView() {
    List<Widget> lessonsWidgets = [];
    lessons.forEach((lesson) {
      lessonsWidgets.add(
        new LessonCard(
          title: lesson.getLessonTitle(),
          id: lesson.getLessonId(),
        ),
      );
    });
    update(lessonsView: lessonsWidgets);
  }

  @override
  void update(
      {phoneNumber,
      organisationName,
      organisationEmail,
      organisationId,
      subjects,
      educators,
      educatorsView,
      subjectsView,
      lessons,
      lessonsView}) {
    CurrentOrganisationModel(controller,
            organisationId: organisationId ?? this.organisationId,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            organisationName: organisationName ?? this.organisationName,
            organisationEmail: organisationEmail ?? this.organisationEmail,
            subjects: subjects ?? this.subjects,
            educators: educators ?? this.educators,
            educatorsView: educatorsView ?? this.educatorsView,
            subjectsView: subjectsView ?? this.subjectsView,
            lessons: lessons ?? this.lessons,
            lessonsView: lessonsView ?? this.lessonsView)
        .updateMomentum();
  }
}
