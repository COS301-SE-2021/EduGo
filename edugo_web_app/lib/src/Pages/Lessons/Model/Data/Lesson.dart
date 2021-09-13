import 'package:edugo_web_app/src/Pages/VirtualEntityStore/Model/Data/VirtualEntities.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntityStore/Model/Data/VirtualEntity.dart';

class Lesson {
  String _title;
  String _description;
  int _lessonId;
  List<VirtualEntity> _virtualEntities;

  Lesson({imageLink, title, description, virtualEntities, lessonId})
      : _description = description,
        _title = title,
        _lessonId = lessonId,
        _virtualEntities = virtualEntities;

  int getLessonId() {
    return _lessonId;
  }

  String getLessonTitle() {
    return _title;
  }

  String getLessonDescription() {
    return _description;
  }

  List<VirtualEntity> getLessonEntities() {
    return _virtualEntities;
  }

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      title: json['title'] as String,
      lessonId: json['id'] as int,
      description: json['description'] as String,
      virtualEntities: VirtualEntities.fromJson(
        json['virtualEntities'],
      ).virtualEntities,
    );
  }
}
