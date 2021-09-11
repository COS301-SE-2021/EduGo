class Lesson {
  String _title;
  String _description;
  int lessonId;

  Lesson({imageLink, title, description, virtualEntities, lessonId})
      : _description = description,
        _title = title,
        lessonId = lessonId;

  int getLessonId() {
    return lessonId;
  }

  String getLessonTitle() {
    return _title;
  }

  String getLessonDescription() {
    return _description;
  }

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
        title: json['title'] as String,
        lessonId: json['id'] as int,
        description: json['description'] as String);
  }
}
