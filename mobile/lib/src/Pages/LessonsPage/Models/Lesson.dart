/**
 * This is the model for a lesson. 
 * The getLessonsBySubject endpoint will return a list of lessons. A lesson 
 * will have an id, a title, a dectription < and a list of entities >. 
 * All of this will be passed into the LessonCardWidget on the LessonPage page. 
 */

import 'package:json_annotation/json_annotation.dart';
part 'Lesson.g.dart';

/*------------------------------------------------------------------------------
 *                            Lesson model class 
 *------------------------------------------------------------------------------
 */

@JsonSerializable()
class Lesson {
  //Lesson id
  @JsonKey(required: true)
  int id;

  //Lesson title
  @JsonKey(required: true)
  String title;

  //Lesson description
  @JsonKey(defaultValue: '')
  String description;

  //Lesson entities
  // @JsonKey(defaultValue: [])
  // List<VirtualEntity> virtualEntities;

  //Lesson constructor
  Lesson(this.id, this.title, this.description);

  //Factory method used in lessonController to map lesson attributes to json
  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}
