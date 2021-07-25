import 'package:json_annotation/json_annotation.dart';

class VirtualEntityData {
  final int ve_id;

  VirtualEntityData({required this.ve_id});

  factory VirtualEntityData.fromJson(Map<String, dynamic> json) {
    return VirtualEntityData(ve_id: json["ve_id"]);
  }
}

@JsonSerializable(explicitToJson: true)
class Quiz {
  @JsonKey(required: true)
  int id;

  @JsonKey(required: true)
  String title;

  @JsonKey(defaultValue: '')
  String description;

  Quiz(this.id, this.title, this.description);

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}

@JsonSerializable()
class Question {
  @JsonKey(required: true)
  int id;

  @JsonKey(required: true, defaultValue: 'TrueFalse')
  String type;

  @JsonKey(required: true)
  String question;

  @JsonKey(defaultValue: '')
  String correctAnswer;

  @JsonKey(defaultValue: null)
  List<String>? options;

  Question(this.id, this.type, this.question, this.correctAnswer, this.options);

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}