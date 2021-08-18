import 'package:edugo_web_app/src/Pages/Admin/View/Widgets/AdminWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

import 'Data/User.dart';

class AdminModel extends MomentumModel<AdminController> {
  final String token;
  final int currentSubjectId;
  final int currentLessonId;
  final String organisationName;
  final int organisationId;
  final List<User> educators;
  final List<Widget> educatorCards;
  final String virtualEntityViewerModelLink;

  AdminModel(AdminController controller,
      {this.organisationName,
      this.organisationId,
      this.currentLessonId,
      this.virtualEntityViewerModelLink,
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

  void setVirtualEntityViewerModelLink(String link) {
    update(virtualEntityViewerModelLink: link);
  }

  void setOrganisationId(int id) {
    update(organisationId: id);
  }

  void setOrganisationName(String name) {
    update(organisationName: name);
  }

  String getToken() {
    return token;
  }

  String getVirtualEntityViewerModelLink() {
    return virtualEntityViewerModelLink;
  }

  int getCurrentSubjectId() {
    return currentSubjectId;
  }

  int getCurrentLessonId() {
    return currentLessonId;
  }

  int getOrganisationId() {
    return currentLessonId;
  }

  @override
  void update(
      {organisationName,
      organisationId,
      educators,
      educatorCards,
      token,
      currentSubjectId,
      virtualEntityViewerModelLink,
      currentLessonId}) {
    AdminModel(controller,
            organisationName: organisationName ?? this.organisationName,
            organisationId: organisationId ?? this.organisationId,
            educators: educators ?? this.educators,
            educatorCards: educatorCards ?? this.educatorCards,
            token: token ?? this.token,
            currentSubjectId: currentSubjectId ?? this.currentSubjectId,
            currentLessonId: currentLessonId ?? this.currentLessonId,
            virtualEntityViewerModelLink: virtualEntityViewerModelLink ??
                this.virtualEntityViewerModelLink)
        .updateMomentum();
  }
}
