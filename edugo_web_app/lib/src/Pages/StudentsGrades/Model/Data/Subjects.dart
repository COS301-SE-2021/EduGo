import 'package:edugo_web_app/src/Pages/StudentsGrades/Model/Data/Subject.dart';

class Subjects {
  final List<Subject> subjects;

  Subjects({this.subjects});

  factory Subjects.fromJson(Map<String, dynamic> subjectsJson) {
    var list = subjectsJson['subjects'] as List;

    List<Subject> subjectList =
        list.map((subject) => Subject.fromJson(subject)).toList();
    return Subjects(subjects: subjectList);
  }
}
