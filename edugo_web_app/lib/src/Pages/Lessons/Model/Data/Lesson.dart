class Lesson {
  String _title;
  String _description;
  // List<VirtualEntity> _virtualEntities;
  String lessonId;

  Lesson({imageLink, title, description, virtualEntities, lessonId})
      : _description = description,
        _title = title,
        // _virtualEntities = virtualEntities,
        lessonId = lessonId;

  void setLessonTitle(String title) {
    _title = title;
  }

  void setLessonDescription(String description) {
    _description = description;
  }

  // void addLessonVirtualEntity(VirtualEntity virtualEntity) {
  //   _virtualEntities.add(virtualEntity);
  // }

  void setLessonId(String lessonId) {
    lessonId = lessonId;
  }

  String getLessonId() {
    return lessonId;
  }

  String getLessonTitle() {
    return _title;
  }

  String getLessonDescription() {
    return _description;
  }

  // List<VirtualEntity> getLessonVirtualEntities() {
  //   return _virtualEntities;
  // }

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
        title: json['title'] as String,
        lessonId: json['id'].toString(),
        description: json['image'] as String);
  }
}
