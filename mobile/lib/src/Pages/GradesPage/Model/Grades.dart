/**
 * This is the model for the grades. The getGrades endpoint
 * will return a list of subjects. The subject will have an id, a title 
 * and a mark(in a percentage) and a list of lessons. This will be used in the 
 * subjects card on the grades page. The lessons will have a mark, an id and a 
 * list of quizzes.The list of quizzes will have an id, a quiz mark the 
 * student got, and the total quiz mark
 */

import 'package:json_annotation/json_annotation.dart';
part 'Grades.g.dart';

@JsonSerializable()
class Subject {
  //Subject id
  @JsonKey(required: true)
  int id;

  //Subject title
  @JsonKey(required: true)
  String title;

  //Overall subject mark in a percentage
  @JsonKey(required: true)
  int mark;

  //List of lessons
  @JsonKey(required: true)
  List<Lesson> lessons;

  //Subject constructor
  Subject(this.id, this.lessons, this.mark, this.title);

  //Factory
  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}

@JsonSerializable()
class Lesson {
  //Lesson id
  @JsonKey(required: true)
  int id;

  //Overall lesson mark in a percentage
  @JsonKey(required: true)
  int mark;

  //List of lessons
  @JsonKey(required: true)
  List<Quiz> quizzes;

  Lesson(this.id, this.mark, this.quizzes);

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}

@JsonSerializable()
class Quiz {
  //quiz id
  @JsonKey(required: true)
  int id;

  //Overall student mark for the quiz
  @JsonKey(required: true)
  int studentMark;

  //Overall quiz mark
  @JsonKey(required: true)
  int quizTotal;

  Quiz(this.id, this.quizTotal, this.studentMark);

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}
