import 'package:json_annotation/json_annotation.dart';

part 'UpcomingLessonsModels.g.dart';

@JsonSerializable()
class UpcomingLesson {
  @JsonKey(required: true)
  final int id;

  @JsonKey(required: true)
  final String title;

  @JsonKey(required: true)
  final String description;

  @JsonKey(required: true)
  final String startTime;

  @JsonKey(required: true)
  final String endTime;

  @JsonKey(name: 'subject', required: true)
  final String subjectTitle;

  UpcomingLesson(this.id, this.title, this.description, this.startTime, this.endTime, this.subjectTitle);

  factory UpcomingLesson.fromJson(Map<String, dynamic> json) => _$UpcomingLessonFromJson(json);
  Map<String, dynamic> toJson() => _$UpcomingLessonToJson(this);
}