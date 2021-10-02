import 'package:edugo_web_app/src/Pages/EduGo.dart';

import 'Data/User.dart';

class AdminModel extends MomentumModel<AdminController> {
  final String token;
  final bool adminLoadController;
  final int currentSubjectId;
  final int currentLessonId;
  final String organisationName;
  final int organisationId;
  final List<User> educators;
  final List<Widget> educatorCards;
  final String userName;
  final String virtualEntityViewerModelLink;
  final String currentSubjectImageLink;
  final User currentUser;

  AdminModel(AdminController controller,
      {this.organisationName,
      this.currentSubjectImageLink,
      this.userName,
      this.currentUser,
      this.organisationId,
      this.adminLoadController,
      this.currentLessonId,
      this.virtualEntityViewerModelLink,
      this.currentSubjectId,
      this.token,
      this.educatorCards,
      this.educators})
      : super(controller);

  @override
  void update(
      {organisationName,
      organisationId,
      educators,
      educatorCards,
      token,
      currentSubjectId,
      virtualEntityViewerModelLink,
      currentLessonId,
      userName,
      currentUser,
      adminLoadController,
      currentSubjectImageLink}) {
    AdminModel(controller,
            currentUser: currentUser ?? this.currentUser,
            organisationName: organisationName ?? this.organisationName,
            userName: userName ?? this.userName,
            organisationId: organisationId ?? this.organisationId,
            educators: educators ?? this.educators,
            educatorCards: educatorCards ?? this.educatorCards,
            token: token ?? this.token,
            currentSubjectId: currentSubjectId ?? this.currentSubjectId,
            currentLessonId: currentLessonId ?? this.currentLessonId,
            virtualEntityViewerModelLink: virtualEntityViewerModelLink ??
                this.virtualEntityViewerModelLink,
            adminLoadController:
                adminLoadController ?? this.adminLoadController,
            currentSubjectImageLink:
                currentSubjectImageLink ?? this.currentSubjectImageLink)
        .updateMomentum();
  }
}
