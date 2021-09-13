import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/ViewLesson/View/Widgets/ViewLessonWidgets.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntityStore/Model/Data/VirtualEntity.dart';

class ViewLessonModel extends MomentumModel<ViewLessonController> {
  final List<VirtualEntity> entities;
  final List<Widget> lessonVirtualEntityCards;
  final String lessonId;
  final String lessonTitle;
  final String lessonDescription;

  final String currentEntityImage;
  ViewLessonModel(ViewLessonController controller,
      {this.entities,
      this.currentEntityImage,
      this.lessonId,
      this.lessonVirtualEntityCards,
      this.lessonDescription,
      this.lessonTitle})
      : super(controller);

// Info: Update lesson virtual entity cards
  void updateLessonVirtualEntityCards() {
    List<Widget> lessonVirtualEntityCardsUpdate = [];
    entities.forEach(
      (entity) {
        lessonVirtualEntityCardsUpdate.add(
          new VirtualEntitySelectorCard(
            title: entity.getVirtualEntityName(),
            link: entity.getThumbNail(),
          ),
        );
      },
    );
    if (lessonVirtualEntityCardsUpdate.isEmpty) {
      lessonVirtualEntityCardsUpdate.add(Text('No Entities'));
    }
    update(
        currentEntityImage: entities.isEmpty ? '' : entities[0].getThumbNail());
    update(lessonVirtualEntityCards: lessonVirtualEntityCardsUpdate);
  }

  @override
  void update(
      {List<Widget> lessonVirtualEntityCards,
      List<VirtualEntity> entities,
      String lessonTitle,
      String lessonDescription,
      String lessonId,
      String currentEntityImage}) {
    ViewLessonModel(controller,
            entities: entities ?? this.entities,
            lessonId: lessonId ?? this.lessonId,
            lessonTitle: lessonTitle ?? this.lessonTitle,
            lessonVirtualEntityCards:
                lessonVirtualEntityCards ?? this.lessonVirtualEntityCards,
            lessonDescription: lessonDescription ?? this.lessonDescription,
            currentEntityImage: currentEntityImage ?? this.currentEntityImage)
        .updateMomentum();
  }
}
