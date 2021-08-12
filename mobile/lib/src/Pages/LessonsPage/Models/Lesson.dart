import 'package:json_annotation/json_annotation.dart';
// import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';

part 'Lesson.g.dart';

@JsonSerializable()
class Lesson {
  @JsonKey(required: true)
  int id;

  @JsonKey(required: true)
  String title;

  @JsonKey(defaultValue: '')
  String description;

  @JsonKey(defaultValue: '')
  String startTime;

  @JsonKey(defaultValue: '')
  String endTime;

  // @JsonKey(defaultValue: [])
  // List<VirtualEntity> virtualEntities;

  Lesson(this.id, this.title, this.description, this.startTime, this.endTime);

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}
