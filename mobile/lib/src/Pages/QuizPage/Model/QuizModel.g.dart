// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuizModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quiz _$QuizFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return Quiz(
    json['id'] as int,
    (json['questions'] as List<dynamic>?)
        ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'id': instance.id,
      'questions': instance.questions?.map((e) => e.toJson()).toList(),
    };

Question _$QuestionFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'type', 'question']);
  return Question(
    json['id'] as int,
    _$enumDecode(_$QuestionTypeEnumMap, json['type'],
        unknownValue: QuestionType.TrueFalse),
    json['question'] as String,
    json['correctAnswer'] as String? ?? '',
    (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$QuestionTypeEnumMap[instance.type],
      'question': instance.question,
      'correctAnswer': instance.correctAnswer,
      'options': instance.options,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$QuestionTypeEnumMap = {
  QuestionType.TrueFalse: 'TrueFalse',
  QuestionType.MultipleChoice: 'MultipleChoice',
};
