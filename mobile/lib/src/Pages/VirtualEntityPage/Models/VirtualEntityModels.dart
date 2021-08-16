import 'package:json_annotation/json_annotation.dart';

part 'VirtualEntityModels.g.dart';

class VirtualEntityData {
  final int ve_id;

  VirtualEntityData({required this.ve_id});

  factory VirtualEntityData.fromJson(Map<String, dynamic> json) {
    return VirtualEntityData(ve_id: json["ve_id"]);
  }
}

@JsonSerializable(explicitToJson: true)
class VirtualEntity {
  @JsonKey(required: true)
  int id;

  @JsonKey(required: true)
  String title;

  @JsonKey(defaultValue: '')
  String description;

  @JsonKey(defaultValue: null)
  Model? model;

  VirtualEntity(this.id, this.title, this.description);

  factory VirtualEntity.fromJson(Map<String, dynamic> json) =>
      _$VirtualEntityFromJson(json);
  Map<String, dynamic> toJson() => _$VirtualEntityToJson(this);
}

@JsonSerializable()
class Model {
  @JsonKey(required: true)
  String name;

  @JsonKey(defaultValue: '')
  String description;

  @JsonKey(required: true)
  String file_name;

  @JsonKey(required: true)
  String file_link;

  @JsonKey(required: false, defaultValue: 0)
  int file_size;

  @JsonKey(required: false, defaultValue: '')
  String file_type;

  Model(this.name, this.description, this.file_name, this.file_link,
      this.file_size, this.file_type);

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);
  Map<String, dynamic> toJson() => _$ModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Quiz {
  @JsonKey(required: true)
  int id;

  @JsonKey(required: true)
  String title;

  @JsonKey(defaultValue: '')
  String description;

  @JsonKey(defaultValue: null)
  List<Question>? questions;

  Quiz(this.id, this.title, this.description, this.questions);

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}

enum QuestionType {
  @JsonValue("TrueFalse")
  TrueFalse,
  @JsonValue("MultipleChoice")
  MultipleChoice,
  @JsonValue("FreeText")
  FreeText,
}

QuestionType toQuestionType(String type) {
  QuestionType t = QuestionType.values.firstWhere(
      (element) => element.toString() == "QuestionType.${type}",
      orElse: () => QuestionType.TrueFalse);
  return t;
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
