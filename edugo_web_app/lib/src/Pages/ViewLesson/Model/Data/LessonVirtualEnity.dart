class LessonVirtualEntity {
  String _title;
  String _modelLink;

  LessonVirtualEntity({
    title,
    modelLink,
  })  : _title = title,
        _modelLink = modelLink;

  String getTitle() {
    return _title;
  }

  String getModelLink() {
    return _modelLink;
  }

  factory LessonVirtualEntity.fromJson(Map<String, dynamic> json) {
    return LessonVirtualEntity(
        title: json['title'] as String,
        modelLink: json['description'] as String);
  }
}
