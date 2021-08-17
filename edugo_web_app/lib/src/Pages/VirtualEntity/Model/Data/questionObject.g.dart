// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionObject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionObject _$QuestionObjectFromJson(Map<String, dynamic> json) {
  return QuestionObject(
    question: json['question'] as String,
    correctAnswer: json['correctAnswer'] as String,
    currentOptionInput: json['currentOptionInput'] as String,
    options:
        (json['options'] as List<dynamic>).map((e) => e as String).toList(),
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$QuestionObjectToJson(QuestionObject instance) =>
    <String, dynamic>{
      'question': instance.question,
      'currentOptionInput': instance.currentOptionInput,
      'type': instance.type,
      'correctAnswer': instance.correctAnswer,
      'options': instance.options,
    };
