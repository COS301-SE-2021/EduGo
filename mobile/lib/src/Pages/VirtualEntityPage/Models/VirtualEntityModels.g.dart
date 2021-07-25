// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VirtualEntityModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VirtualEntity _$VirtualEntityFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'title']);
  return VirtualEntity(
    json['id'] as int,
    json['title'] as String,
    json['description'] as String? ?? '',
  )..model = json['model'] == null
      ? null
      : Model.fromJson(json['model'] as Map<String, dynamic>);
}

Map<String, dynamic> _$VirtualEntityToJson(VirtualEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'model': instance.model?.toJson(),
    };

Model _$ModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['name', 'file_name', 'file_link']);
  return Model(
    json['name'] as String,
    json['description'] as String? ?? '',
    json['file_name'] as String,
    json['file_link'] as String,
    json['file_size'] as int,
    json['file_type'] as String,
  );
}

Map<String, dynamic> _$ModelToJson(Model instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'file_name': instance.file_name,
      'file_link': instance.file_link,
      'file_size': instance.file_size,
      'file_type': instance.file_type,
    };

Quiz _$QuizFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'title']);
  return Quiz(
    json['id'] as int,
    json['title'] as String,
    json['description'] as String? ?? '',
  );
}

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };

Question _$QuestionFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'type', 'question']);
  return Question(
    json['id'] as int,
    _$enumDecodeNullable(_$QuestionTypeEnumMap, json['type']) ??
        QuestionType.TrueFalse,
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

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$QuestionTypeEnumMap = {
  QuestionType.TrueFalse: 'TrueFalse',
  QuestionType.MultipleChoice: 'MultipleChoice',
  QuestionType.FreeText: 'FreeText',
};
