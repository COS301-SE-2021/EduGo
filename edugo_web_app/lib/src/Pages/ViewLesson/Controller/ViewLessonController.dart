import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/ViewLesson/Model/Data/LessonVirtualEntities.dart';

class ViewLessonController extends MomentumController<ViewLessonModel> {
  @override
  ViewLessonModel init() {
    return ViewLessonModel(this, entities: [], lessonVirtualEntityCards: []);
  }

  void viewLessonDetails(
      String title, String description, String entitiesJson) {
    model.update(lessonTitle: title);
    model.update(lessonDescription: description);
    model.updateLessonVirtualEntityCards();
    // Map<String, dynamic> _entities = jsonDecode(entitiesJson);
    // model.updateEntities(LessonVirtualEntities.fromJson(_entities).entities);
  }
}
