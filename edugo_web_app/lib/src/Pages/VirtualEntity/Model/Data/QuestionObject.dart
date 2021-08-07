class QuestionObject {
  String question;
  String currentOptionInput;
  String type;
  String correctAnswer;
  List<String> options = [];
  String questionToString() {
    return '{"type":' +
        type +
        ',"question":' +
        question +
        ',"options":' +
        options.toString() +
        ',"correctAnswer": ' +
        correctAnswer +
        '}';
  }
}
