import 'package:edugo_web_app/src/Pages/EduGo.dart';

part 'questionObject.g.dart';

@JsonSerializable()
class QuestionObject {
  QuestionObject(
      {this.question,
      this.correctAnswer,
      this.currentOptionInput,
      this.options,
      this.type});
  String question;
  String currentOptionInput;
  String type;
  String correctAnswer;
  List<String> options = [];
  factory QuestionObject.fromJson(Map<String, dynamic> json) =>
      _$QuestionObjectFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionObjectToJson(this);
}
