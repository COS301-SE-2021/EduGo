/**
 * This is the model for a virtual entity. 
 * The getVirtualEntity endpoint will return a the information 
 * with regards to the specific virtual entity id that is passed in. 
 */

import 'package:json_annotation/json_annotation.dart';
part 'VirtualEntityModels.g.dart';

class VirtualEntityData {
  //Holds the virtual enitity id
  final int ve_id;

  //Virtual entity data constructor
  VirtualEntityData({required this.ve_id});

  factory VirtualEntityData.fromJson(Map<String, dynamic> json) {
    return VirtualEntityData(ve_id: json["ve_id"]);
  }
}

@JsonSerializable(explicitToJson: true)
class VirtualEntity {
  //Holds the virtual entity ID
  @JsonKey(required: true)
  int id;

  //Holds the virtual entity title
  @JsonKey(required: true)
  String title;

  //Holds the virtual entity description
  @JsonKey(defaultValue: [])
  List<String> description;

  //Holds the actual model
  @JsonKey(defaultValue: null)
  Model? model;

  //Virtual entity constructor
  VirtualEntity(this.id, this.title, this.description, this.model);

  factory VirtualEntity.fromJson(Map<String, dynamic> json) =>
      _$VirtualEntityFromJson(json);
  Map<String, dynamic> toJson() => _$VirtualEntityToJson(this);
}

@JsonSerializable()
class Model {
  //Holds the filelink
  @JsonKey(required: true)
  String fileLink;

  //Holds a thumbnail of the 3d model
  @JsonKey(required: true)
  String thumbnail;

  //Model consatructor
  Model(this.fileLink, this.thumbnail);

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);
  Map<String, dynamic> toJson() => _$ModelToJson(this);
}
