import 'package:json_annotation/json_annotation.dart';
//import 'package:mobile/src/Pages/LessonsPage/Models/LessonModels.dart';

part 'SubjectModels.g.dart';

@JsonSerializable()
class Subject {
  @JsonKey(required: true)
  int id;

  @JsonKey(required: true)
  String title;

  //If grade is 0, then the subject does not have a grade
  @JsonKey(required: false, defaultValue: 0)
  int grade;

  // @JsonKey(required: false, defaultValue: [])
  // List<Lesson> lessons;

  Subject(this.id, this.title, this.grade);

  factory Subject.fromJson(Map<String, dynamic> json) => _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}