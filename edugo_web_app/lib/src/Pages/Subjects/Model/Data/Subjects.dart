import 'Subject.dart';

class Subjects {
  final List<Subject> subjects;

  Subjects({this.subjects});

  factory Subjects.fromJson(Map<String, dynamic> subjectsJson) {
    var list = subjectsJson['data'] as List;

    List<Subject> subjectList =
        list.map((subject) => Subject.fromJson(subject)).toList();
    return Subjects(subjects: subjectList);
  }
}
