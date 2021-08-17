class Subject {
  String _title;
  String _grade;
  int _id;
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

  String getSubjectTitle() {
    return _title;
  }

  int getSubjectId() {
    return _id;
  }

  String getSubjectGrade() {
    return _grade;
  }

  String getSubjectImageLink() {
    return _imageLink;
  }

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
        title: json['title'] as String,
        id: json['id'] as int,
        grade: json['grade'].toString(),
        imageLink: json['image'] as String);
  }
}
