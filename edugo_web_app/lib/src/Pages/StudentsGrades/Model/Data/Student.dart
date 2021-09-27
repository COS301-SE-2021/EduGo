class Student {
  String _name;
  double _studentGrade;

  Student({
    name,
    studentGrade,
  })  : _name = name,
        _studentGrade = studentGrade;

  double getGrade() {
    return _studentGrade;
  }

  String getName() {
    return _name;
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['username'] as String,
      studentGrade: json['studentgrade'] as double,
    );
  }
}
