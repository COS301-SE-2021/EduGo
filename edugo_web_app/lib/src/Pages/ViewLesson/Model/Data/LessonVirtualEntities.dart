import 'package:edugo_web_app/src/Pages/ViewLesson/Model/Data/LessonVirtualEntity.dart';

class LessonVirtualEntities {
  final List<LessonVirtualEntity> entities;

  LessonVirtualEntities({this.entities});

  factory LessonVirtualEntities.fromJson(Map<String, dynamic> entitiesJson) {
    var list = entitiesJson['data'] as List;
    List<LessonVirtualEntity> entitiesList =
        list.map((entity) => LessonVirtualEntity.fromJson(entity)).toList();
    return LessonVirtualEntities(entities: entitiesList);
  }
}
