import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntityStore/Model/Data/VirtualEntity.dart';

class ViewLessonModel extends MomentumModel<ViewLessonController> {
  final List<VirtualEntity> entities;
  final List<Widget> lessonVirtualEntityCards;
  final String lessonId;
  final String lessonTitle;
  final String lessonDescription;
  final String currentEntityImage;
  final String currentModel;
  final bool addStoreLoadController;
  final bool addViewLoadController;
  final String responseString;

  ViewLessonModel(ViewLessonController controller,
      {this.entities,
      this.currentModel,
      this.currentEntityImage,
      this.responseString,
      this.lessonId,
      this.addStoreLoadController,
      this.addViewLoadController,
      this.lessonVirtualEntityCards,
      this.lessonDescription,
      this.lessonTitle})
      : super(controller);

  @override
  void update(
      {List<Widget> lessonVirtualEntityCards,
      List<VirtualEntity> entities,
      String lessonTitle,
      String lessonDescription,
      String lessonId,
      String currentEntityImage,
      String currentModel,
      bool addStoreLoadController,
      bool addViewLoadController,
      String responseString}) {
    ViewLessonModel(controller,
            entities: entities ?? this.entities,
            lessonId: lessonId ?? this.lessonId,
            lessonTitle: lessonTitle ?? this.lessonTitle,
            lessonVirtualEntityCards:
                lessonVirtualEntityCards ?? this.lessonVirtualEntityCards,
            lessonDescription: lessonDescription ?? this.lessonDescription,
            currentEntityImage: currentEntityImage ?? this.currentEntityImage,
            currentModel: currentModel ?? this.currentModel,
            addStoreLoadController:
                addStoreLoadController ?? this.addStoreLoadController,
            addViewLoadController:
                addViewLoadController ?? this.addViewLoadController,
            responseString: responseString ?? this.responseString)
        .updateMomentum();
  }
}
