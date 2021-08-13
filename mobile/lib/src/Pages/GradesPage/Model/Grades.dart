/**
 * This is the model for the grades. 
 * The getStudentGrades endpoint will return a list of subjects. A subject 
 * will have an id, a title, a mark (as a percentage) and a list of lessons. 
 * All of this will be passed into the GradesSubjectCard on the grades page. 
 * A lesson will have a mark, an id and a list of quizzes. The list of quizzes 
 * will have an id, a title, a quiz mark that the student received, and the total 
 * quiz mark
 */

import 'package:json_annotation/json_annotation.dart';
part 'Grades.g.dart';

/*------------------------------------------------------------------------------
 *                        Subject model class for grades
 *------------------------------------------------------------------------------
 */

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

  //Factory method used in gradesController to map subject attributes to json
  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}

/*------------------------------------------------------------------------------
 *                        Lesson model class for grades
 *------------------------------------------------------------------------------
 */

@JsonSerializable()
class Lesson {
  //Lesson id
  @JsonKey(required: true)
  int id;

  //Overall lesson mark in a percentage
  @JsonKey(required: true)
  int mark;

  //Lesson title
  @JsonKey(required: true)
  String title;

  //List of quizzes for each lesson.
  //(A lesson can have many virtual entities therefore many quizzes
  //as a quiz is attached to the virtual entity and not the lesson)
  @JsonKey(required: true)
  List<Quiz> quizzes;

  //Lesson constructor
  Lesson(this.id, this.mark, this.quizzes, this.title);

  //Factory method used in gradesController to map lesson attributes to json
  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}

/*------------------------------------------------------------------------------
 *                        Quiz model class for grades
 *------------------------------------------------------------------------------
 */

@JsonSerializable()
class Quiz {
  //Quiz id
  @JsonKey(required: true)
  int id;

  //Quiz title
  @JsonKey(required: true)
  String title;

  //Overall student mark for the quiz
  //(Not a percentage)
  @JsonKey(required: true)
  int studentMark;

  //Overall quiz mark
  @JsonKey(required: true)
  int quizTotal;

  //List of student quiz answers
  @JsonKey(required: true)
  List<String> studentAnswers;

  //List of correct quiz answers
  @JsonKey(required: true)
  List<String> correctAnswers;

  //Quiz constructor
  Quiz(this.id, this.quizTotal, this.studentMark, this.title,
      this.correctAnswers, this.studentAnswers);

  //Factory method used in gradesController to map quiz attributes to json
  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}
