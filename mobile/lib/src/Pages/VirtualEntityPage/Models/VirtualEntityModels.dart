import 'package:json_annotation/json_annotation.dart';

part 'VirtualEntityModels.g.dart';

class VirtualEntityData {
  final int ve_id;

  VirtualEntityData({required this.ve_id});

  factory VirtualEntityData.fromJson(Map<String, dynamic> json) {
    return VirtualEntityData(ve_id: json["ve_id"]);
  }
}

@JsonSerializable(explicitToJson: true)
class VirtualEntity {
  @JsonKey(required: true)
  int id;

  @JsonKey(required: true)
  String title;

  @JsonKey(defaultValue: '')
  String description;

  @JsonKey(defaultValue: [])
  List<String> information;

  @JsonKey(defaultValue: null)
  Model? model;

  VirtualEntity(
      this.id, this.title, this.description, this.information, this.model);

  factory VirtualEntity.fromJson(Map<String, dynamic> json) =>
      _$VirtualEntityFromJson(json);
  Map<String, dynamic> toJson() => _$VirtualEntityToJson(this);
}

@JsonSerializable()
class Model {
  @JsonKey(required: true)
  String fileLink;

  @JsonKey(required: true)
  String thumbnail;

  Model(this.fileLink, this.thumbnail);

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);
  Map<String, dynamic> toJson() => _$ModelToJson(this);
}
