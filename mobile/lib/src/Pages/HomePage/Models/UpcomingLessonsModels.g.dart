// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UpcomingLessonsModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingLesson _$UpcomingLessonFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'id',
    'title',
    'description',
    'startTime',
    'endTime',
    'subject'
  ]);
  return UpcomingLesson(
    json['id'] as int,
    json['title'] as String,
    json['description'] as String,
    json['startTime'] as String,
    json['endTime'] as String,
    json['subject'] as String,
  );
}

Map<String, dynamic> _$UpcomingLessonToJson(UpcomingLesson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'subject': instance.subjectTitle,
    };
