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
    json['file_size'] as int? ?? 0,
    json['file_type'] as String? ?? '',
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
