import 'package:edugo_web_app/src/Pages/StudentsGrades/Model/Data/Student.dart';
import 'package:edugo_web_app/src/Pages/StudentsGrades/Model/Data/Students.dart';

class Subject {
  String _name;
  List<Student> _students;
  Subject({
    name,
    students,
  })  : _students = students,
        _name = name;

  String getSubjectName() {
    return _name;
  }

  List<Student> getStudents() {
    return _students;
  }

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      name: json['title'] as String,
      students: Students.fromJson(
        json['students'],
      ),
    );
  }
}
