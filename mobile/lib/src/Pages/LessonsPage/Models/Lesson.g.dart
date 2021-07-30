// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'title']);
  return Lesson(
    json['id'] as int,
    json['title'] as String,
    json['description'] as String? ?? '',
    json['startTime'] as String? ?? '',
    json['endTime'] as String? ?? '',
  );
}

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
