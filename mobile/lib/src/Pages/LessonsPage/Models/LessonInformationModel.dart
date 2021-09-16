import 'package:mobile/src/Pages/LessonsPage/Controller/LessonInformationController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:momentum/momentum.dart';

class LessonInformationModel
    extends MomentumModel<LessonInformationController> {
  //all the data the LessonInformation Page has to display
  final String lessonTitle;
  final int lessonID;
  final String lessonDescription;
  final List<VirtualEntity> lessonVirtualEntity;

  LessonInformationModel(
    LessonInformationController controller, {
    required this.lessonTitle,
    required this.lessonID,
    required this.lessonDescription,
    required this.lessonVirtualEntity,
  }) : super(controller);

  @override
  void update({
    //update these details on the screen
    String? lessonTitle,
    int? lessonID,
    String? lessonDescription,
    List<VirtualEntity>? lessonVirtualEntity,
  }) {
    LessonInformationModel(
      controller,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      lessonID: lessonID ?? this.lessonID,
      lessonDescription: lessonDescription ?? this.lessonDescription,
      lessonVirtualEntity: lessonVirtualEntity ?? this.lessonVirtualEntity,
    ).updateMomentum();
  }
}
