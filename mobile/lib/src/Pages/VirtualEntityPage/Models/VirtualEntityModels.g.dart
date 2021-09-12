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
    (json['information'] as List<dynamic>?)?.map((e) => e as String).toList() ??
        [],
    json['model'] == null
        ? null
        : Model.fromJson(json['model'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VirtualEntityToJson(VirtualEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'information': instance.information,
      'model': instance.model?.toJson(),
    };

Model _$ModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['fileLink', 'thumbnail']);
  return Model(
    json['fileLink'] as String,
    json['thumbnail'] as String,
  );
}

Map<String, dynamic> _$ModelToJson(Model instance) => <String, dynamic>{
      'fileLink': instance.fileLink,
      'thumbnail': instance.thumbnail,
    };
