class Lesson {
  String _title;
  String _description;
  String _imageLink;
  String _date;
  String _endTime;
  String _virtualEntityId;
  String _subjectId;
  String _startTime;

  Lesson(
      {imageLink,
      title,
      description,
      date,
      startTime,
      endTime,
      virtualEntityId,
      subjectId})
      : _description = description,
        _imageLink = imageLink,
        _title = title,
        _date = date,
        _startTime = startTime,
        _endTime = endTime,
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

  void setLessonStartTime(String startTime) {
    _startTime = startTime;
  }

  void setLessonEndTime(String endTime) {
    _endTime = endTime;
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

  String getLessonStartTime() {
    return _startTime;
  }

  String getLessonEndTime() {
    return _endTime;
  }
}
