// import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
// import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
// import 'package:momentum/momentum.dart';

// class QuizPageModel extends MomentumModel<QuizController> {
//   QuizPageModel(
//     QuizController controller, {
//     required this.quizes,
//   }) : super(controller);

//   final List<Quiz> quizes;

//   @override
//   void update({List<Quiz>? quizes}) {
//     QuizPageModel(controller, quizes: quizes ?? this.quizes).updateMomentum();
//   }
// }

/**
 * This is the model for a quiz. 
 * The getQuizesByLesson endpoint will return a list of quizzes for a specific lesson
 * in a subject. A quiz will have a lesson id, a title, a grade < and a list of lessons >. 
 * All of this will be passed into the SubjectCardWidget on the SubjectPage page. 
 */

import 'package:json_annotation/json_annotation.dart';
part 'Quiz.g.dart';

@JsonSerializable()
class Quiz {
  //Quiz id
  @JsonKey(required: true)
  int id;

  //Quiz quesions
  @JsonKey(defaultValue: null)
  List<Question> questions;

  //Constructor
  Quiz(this.id, this.questions);

  //Factory method used in Qiz Controller to map quizes attributes to json
  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}

@JsonSerializable()
class Question {
  //Question id in a quiz
  @JsonKey(required: true)
  int id;

  //Question type. Can be a true or false or Multiple choice.
  //Question type is defined with an enum
  @JsonKey(required: true, unknownEnumValue: QuestionType.TrueFalse)
  QuestionType type;

  //The actual question in text
  @JsonKey(required: true)
  String question;

  //The correct answer for that question
  @JsonKey(defaultValue: '')
  String correctAnswer;

  //
  @JsonKey(defaultValue: null)
  List<String> options;

  Question(this.id, this.type, this.question, this.correctAnswer, this.options);

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

enum QuestionType {
  @JsonValue("TrueFalse")
  TrueFalse,
  @JsonValue("MultipleChoice")
  MultipleChoice
}
