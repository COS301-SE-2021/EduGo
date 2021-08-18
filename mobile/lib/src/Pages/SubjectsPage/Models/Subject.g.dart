// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'title', 'educatorName']);
  return Subject(
    json['id'] as int,
    json['title'] as String,
    json['grade'] as int? ?? 0,
    json['educatorName'] as String,
    json['image'] as String? ?? '',
  );
}

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'grade': instance.grade,
      'educatorName': instance.educatorName,
      'image': instance.image,
    };
