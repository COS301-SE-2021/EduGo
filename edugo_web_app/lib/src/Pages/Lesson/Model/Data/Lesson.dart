class Lesson {
  String _title;
  String _description;
  // List<VirtualEntity> _virtualEntities;
  String _subjectId;

  Lesson({imageLink, title, description, virtualEntities, subjectId})
      : _description = description,
        _title = title,
        // _virtualEntities = virtualEntities,
        _subjectId = subjectId;

  void setLessonTitle(String title) {
    _title = title;
  }

  void setLessonDescription(String description) {
    _description = description;
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

  // List<VirtualEntity> getLessonVirtualEntities() {
  //   return _virtualEntities;
  // }
}
