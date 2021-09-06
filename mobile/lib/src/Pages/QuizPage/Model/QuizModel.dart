import 'package:json_annotation/json_annotation.dart';

part 'QuizModel.g.dart';

@JsonSerializable(explicitToJson: true)
class Quiz {
  @JsonKey(required: true)
  int id;

  @JsonKey(defaultValue: null)
  List<Question>? questions;

  Quiz(this.id, this.questions);

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}

@JsonSerializable()
class Answer {
  @JsonKey(required: true)
  int question_id;

  @JsonKey(required: true)
  String answer;

  Answer(this.question_id, this.answer);

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}

@JsonSerializable()
class Question {
  @JsonKey(required: true)
  int id;

  @JsonKey(required: true, unknownEnumValue: QuestionType.TrueFalse)
  QuestionType type;

  @JsonKey(required: true)
  String question;

  @JsonKey(defaultValue: '')
  String correctAnswer;

  @JsonKey(defaultValue: null)
  List<String>? options;

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
  // @JsonValue("FreeText")
  // FreeText,
}
