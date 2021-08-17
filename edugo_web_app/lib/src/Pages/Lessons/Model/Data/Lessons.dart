import 'package:edugo_web_app/src/Pages/Lesson/Model/Data/LessonDataObjects.dart';

class Lessons {
  final List<Lesson> lessons;

  Lessons({this.lessons});

  factory Lessons.fromJson(Map<String, dynamic> lessonsJson) {
    var list = lessonsJson['data'] as List;
    List<Lesson> lessonsList =
        list.map((subject) => Lesson.fromJson(subject)).toList();
    return Lessons(lessons: lessonsList);
  }
}
