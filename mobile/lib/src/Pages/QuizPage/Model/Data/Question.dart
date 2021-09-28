// enum QuestionType {
//   TrueFalse,
//   MultipleChoice,
//   FillinTheMissingWord,
//   ImageQuestion,
// }

class Question {
  int _id;
  String _type;
  String _image;
  String _question;
  String _correctAnswer;
  List<String> _answerOptions;
  String _givenAnswer;

  Question(
      {required int id,
      required String type,
      required String image,
      required String question,
      required String correctAnswer,
      required List<String> answerOptions,
      required String givenAnswer})
      : _id = id,
        _type = type,
        _image = image,
        _answerOptions = answerOptions,
        _correctAnswer = correctAnswer,
        _question = question,
        _givenAnswer = "";

  int getId() {
    return _id;
  }

  String getQuestion() {
    return _question;
  }

  String getType() {
    return _type;
  }

  String getImage() {
    return _image;
  }

  String getCorrectAnswer() {
    return _correctAnswer;
  }

  List<String> getAnswerOptions() {
    return _answerOptions;
  }

  String getGivenAnswer() {
    return _givenAnswer;
  }

  void setGivenAnswer(String answer) {
    _givenAnswer = answer;
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    List<dynamic> dynList = json['options'] as List<dynamic>;
    List<String> stringList = dynList.cast<String>();
    return Question(
        id: json['id'] as int,
        type: json['type'] as String,
        image: json['image'] as String,
        question: json['question'] as String,
        correctAnswer: json['correctAnswer'] as String,
        answerOptions: stringList,
        givenAnswer: "");
  }

  Map<String, dynamic> toJson() => {
        'question_id': _id,
        'answer': _givenAnswer,
      };
}
