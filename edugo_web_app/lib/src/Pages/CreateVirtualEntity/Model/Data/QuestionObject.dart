class QuestionObject {
  String question;
  String currentOptionInput;
  String type;
  String correctAnswer;
  List<String> options = [];

  Map<String, dynamic> toJson() => {
        'question': question,
        'type': type,
        'correctAnswer': correctAnswer,
        'options': options,
      };
}
