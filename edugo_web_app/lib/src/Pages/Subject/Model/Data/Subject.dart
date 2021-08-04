class Subject {
  String _title;
  String _grade;
  String _id;
  String _imageLink;
  Subject({
    imageLink,
    title,
    grade,
    id,
  })  : _grade = grade,
        _imageLink = imageLink,
        _title = title,
        _id = id;

  void setSubjectTitle(String title) {
    _title = title;
  }

  void setSubjectId(String id) {
    _id = id;
  }

  void setSubjectGrade(String grade) {
    _grade = grade;
  }

  void setSubjectImageLink(String imageLink) {
    _imageLink = imageLink;
  }

  String getSubjectTitle() {
    return _title;
  }

  String getSubjectId() {
    return _id;
  }

  String getSubjectGrade() {
    return _grade;
  }

  String getSubjectImageLink() {
    return _imageLink;
  }
}
