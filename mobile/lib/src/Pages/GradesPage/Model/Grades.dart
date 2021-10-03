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

  //Subject title/name
  @JsonKey(required: true)
  String subjectName;

  //Overall subject mark in a percentage
  @JsonKey(required: true)
  double gradeAchieved;

  //List of lessons grades and info
  @JsonKey(required: true)
  List<Lesson> lessonGrades;

  //Subject constructor
  Subject(this.id, this.lessonGrades, this.gradeAchieved, this.subjectName);

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
  double gradeAchieved;

  //Lesson title/name
  @JsonKey(required: true)
  String lessonName;

  //List of quizzes for each lesson.
  //(A lesson can have many virtual entities therefore many quizzes
  //as a quiz is attached to the virtual entity and not the lesson)
  @JsonKey(required: true)
  List<Quiz> quizGrades;

  //Lesson constructor
  Lesson(this.id, this.gradeAchieved, this.quizGrades, this.lessonName);

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
  //Quiz name
  @JsonKey(required: true)
  String name;

  //Overall student mark for the quiz
  //(Not a percentage)
  @JsonKey(required: true)
  int student_score;

  //Overall quiz mark
  @JsonKey(required: true)
  int quiz_total;

  //List of student quiz answers
  @JsonKey(required: true)
  List<QuizAnswers> quiz_answers;

  //Quiz constructor
  Quiz(this.name, this.quiz_total, this.student_score, this.quiz_answers);

  //Factory method used in gradesController to map quiz attributes to json
  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}

/*------------------------------------------------------------------------------
 *                        QuizAnswers model class for grades
 *------------------------------------------------------------------------------
 */

@JsonSerializable()
class QuizAnswers {
  //QuizAnswers id
  @JsonKey(required: true)
  int id;

  //student's answer
  @JsonKey(required: true)
  String answer;

  //correct answer
  @JsonKey(required: true)
  String correctAnswer;

  //Question
  @JsonKey(required: true)
  Question question;

  //QuizAnswer constructor
  QuizAnswers(this.id, this.answer, this.correctAnswer, this.question);

  //Factory method used in gradesController to map quiz attributes to json
  factory QuizAnswers.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswersFromJson(json);
  Map<String, dynamic> toJson() => _$QuizAnswersToJson(this);
}

@JsonSerializable()
class Question {
  @JsonKey(required: true)
  String type;

  //correct answer
  @JsonKey(required: true)
  String question;

  String imageLink;

  @JsonKey(required: true)
  int id;

  @JsonKey(required: true)
  List<String> options;

  @JsonKey(required: true)
  String correctAnswer;

  //QuizAnswer constructor
  Question(this.type, this.question, this.id, this.imageLink, this.options,
      this.correctAnswer);

  //Factory method used in gradesController to map quiz attributes to json
  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
