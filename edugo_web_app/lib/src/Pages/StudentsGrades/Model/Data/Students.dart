import 'package:edugo_web_app/src/Pages/StudentsGrades/Model/Data/Student.dart';

class Students {
  final List<Student> students;

  Students({this.students});

  factory Students.fromJson(Map<String, dynamic> studentsJson) {
    var list = studentsJson['students'] as List;
    List<Student> studentsList =
        list.map((student) => Student.fromJson(student)).toList();
    return Students(students: studentsList);
  }
}
