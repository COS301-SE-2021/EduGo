import 'package:edugo_web_app/src/Pages/Admin/View/Widgets/AdminWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

import 'Data/User.dart';

class AdminModel extends MomentumModel<AdminController> {
  final String token;
  final int currentSubjectId;
  final int currentLessonId;
  final String organisationName;
  final List<User> educators;
  final List<Widget> educatorCards;
  AdminModel(AdminController controller,
      {this.organisationName,
      this.currentLessonId,
      this.currentSubjectId,
      this.token,
      this.educatorCards,
      this.educators})
      : super(controller);

  void updateEducators(List<User> educators) {
    update(educators: educators);
  }

  void updateEducatorsView() {
    List<Widget> educatorsWidgets = [];
    //*make request to get organisation educators and map to User object

    educators.forEach((educator) {
      educatorsWidgets.add(new EducatorCard(
        name: educator.getName(),
        admin: educator.getAdmin(),
      ));
      educatorsWidgets.add(SizedBox(
        height: 20,
      ));
    });
    update(educatorCards: educatorsWidgets);
  }

  void setCurrentSubjectId(int id) {
    update(currentSubjectId: id);
  }

  void setCurrentLessonId(int id) {
    update(currentLessonId: id);
  }

  void setToken(String token) {
    update(token: token);
  }

  String getToken() {
    return token;
  }

  int getCurrentSubjectId() {
    return currentSubjectId;
  }

  int getCurrentLessonId() {
    return currentLessonId;
  }

  @override
  void update(
      {organisationName,
      educators,
      educatorCards,
      token,
      currentSubjectId,
      currentLessonId}) {
    AdminModel(controller,
            organisationName: organisationName ?? this.organisationName,
            educators: educators ?? this.educators,
            educatorCards: educatorCards ?? this.educatorCards,
            token: token ?? this.token,
            currentSubjectId: currentSubjectId ?? this.currentSubjectId,
            currentLessonId: currentLessonId ?? this.currentLessonId)
        .updateMomentum();
  }
}
