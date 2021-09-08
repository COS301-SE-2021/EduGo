import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/ViewLesson/Model/Data/LessonVirtualEnity.dart';
import 'package:edugo_web_app/src/Pages/ViewLesson/View/Widgets/ViewLessonWidgets.dart';

class ViewLessonModel extends MomentumModel<ViewLessonController> {
  final List<LessonVirtualEntity> entities;
  final List<Widget> lessonVirtualEntityCards;
  final String lessonTitle;
  final String lessonDescription;
  ViewLessonModel(ViewLessonController controller,
      {this.entities,
      this.lessonVirtualEntityCards,
      this.lessonDescription,
      this.lessonTitle})
      : super(controller);

// Info: Update list of entities
  void updateEntities(List<LessonVirtualEntity> entitiesUpdate) {
    update(entities: entitiesUpdate);
  }

// Info: Update lesson virtual entity cards
  void updateLessonVirtualEntityCards() {
    List<Widget> lessonVirtualEntityCardsUpdate = [];
    // entities.forEach(
    //   (entity) {
    // lessonVirtualEntityCardsUpdate.add(
    //   new VirtualEntitySelectorCard(
    //     title: entity.getTitle(),
    //     link: entity.getModelLink(),
    //   ),
    // );
    //   },
    // );
    for (int k = 0; k < 4; k++) {
      lessonVirtualEntityCardsUpdate.add(
        new VirtualEntitySelectorCard(
          title: k.toString(),
          link: k.toString(),
        ),
      );
    }
    update(lessonVirtualEntityCards: lessonVirtualEntityCardsUpdate);
  }

  @override
  void update({
    List<Widget> lessonVirtualEntityCards,
    List<LessonVirtualEntity> entities,
    String lessonTitle,
    String lessonDescription,
  }) {
    ViewLessonModel(
      controller,
      entities: entities ?? this.entities,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      lessonVirtualEntityCards:
          lessonVirtualEntityCards ?? this.lessonVirtualEntityCards,
      lessonDescription: lessonDescription ?? this.lessonDescription,
    ).updateMomentum();
  }
}
