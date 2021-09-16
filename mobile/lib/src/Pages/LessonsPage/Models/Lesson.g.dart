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
    json['lessonCompleted'] as String? ?? '',
    (json['virtualEntities'] as List<dynamic>?)
            ?.map((e) => VirtualEntity.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'lessonCompleted': instance.lessonCompleted,
      'virtualEntities': instance.virtualEntities,
    };
