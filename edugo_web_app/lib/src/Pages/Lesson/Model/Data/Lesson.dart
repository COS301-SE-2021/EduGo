class Lesson {
  String _title;
  String _description;
  String _imageLink;
  String _date;
  String _time;
  String _virtualEntityId;
  String _subjectId;

  Lesson(
      {imageLink, title, description, date, time, virtualEntityId, subjectId})
      : _description = description,
        _imageLink = imageLink,
        _title = title,
        _date = date,
        _time = time,
        _virtualEntityId = virtualEntityId,
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

  void setLessonTime(String time) {
    _time = time;
  }

  void setLessonDate(String date) {
    _date = date;
  }

  void setLessonVirtualEntityId(String virtualEntityID) {
    _virtualEntityId = virtualEntityID;
  }

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

  String getLessonVirtualEntityID() {
    return _virtualEntityId;
  }

  String getLessonDate() {
    return _date;
  }

  String getLessonTime() {
    return _time;
  }
}
