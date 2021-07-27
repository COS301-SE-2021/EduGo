// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'title']);
  return Subject(
    json['id'] as int,
    json['title'] as String,
    json['grade'] as int? ?? 0,
  );
}

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'grade': instance.grade,
    };
