/**
 * This is the model for a subject. 
 * The getSubjectsByUser endpoint will return a list of subjects. A subject 
 * will have an id, a title, a grade < and a list of lessons >. 
 * All of this will be passed into the SubjectCardWidget on the SubjectPage page. 
 */

import 'package:json_annotation/json_annotation.dart';
part 'Subject.g.dart';

/*------------------------------------------------------------------------------
 *                            Subject model class 
 *------------------------------------------------------------------------------
 */
@JsonSerializable()
class Subject {
  //Subject id
  @JsonKey(required: true)
  int id;

  //Subject title
  @JsonKey(required: true)
  String title;

  //Subject grade. (Not subject mark. i.e. grade as in grade 11)
  @JsonKey(required: false, defaultValue: 0)
  int grade;

  //Educator name
  @JsonKey(required: true)
  String educatorName;

  // @JsonKey(required: false, defaultValue: [])
  // List<Lesson> lessons;

  String image;

  //Subject constructor
  Subject(this.id, this.title, this.grade, this.educatorName);

  //Factory method used in subjectController to map lesson attributes to json
  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}
