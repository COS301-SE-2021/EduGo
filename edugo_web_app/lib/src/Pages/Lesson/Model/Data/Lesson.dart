import 'package:edugo_web_app/src/Pages/EduGo.dart';

class Lesson {
  String _title;
  String _description;
  String _imageLink;
  // List<VirtualEntity> _virtualEntities;
  String _subjectId;

  Lesson({imageLink, title, description, virtualEntities, subjectId})
      : _description = description,
        _imageLink = imageLink,
        _title = title,
        // _virtualEntities = virtualEntities,
        _subjectId = subjectId;

  void setLessonTitle(String title) {
    _title = title;
  }

  void setLessonDescription(String description) {
    _description = description;
  }

  void setLessonImageLink(String imageLink) {
    _imageLink = imageLink;
  }

  // void addLessonVirtualEntity(VirtualEntity virtualEntity) {
  //   _virtualEntities.add(virtualEntity);
  // }

  void setLessonSubjectId(String subjectId) {
    _subjectId = subjectId;
  }

  String getLessonSubjectId() {
    return _subjectId;
  }

  String getLessonTitle() {
    return _title;
  }

  String getLessonDescription() {
    return _description;
  }

  String getLessonImageLink() {
    return _imageLink;
  }

  // List<VirtualEntity> getLessonVirtualEntities() {
  //   return _virtualEntities;
  // }
}
