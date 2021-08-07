class QuestionObject {
  String question;
  String currentOptionInput;
  String type;
  String correctAnswer;
  List<String> options = [];
  String questionToString() {
    List<String> quotedOptions = [];
    options.forEach(
      (option) {
        if (option != "" && option != null)
          quotedOptions.add('"' + option + '"');
      },
    );
    if (quotedOptions.isEmpty || question == "") return "Quiz is not valid";
    return '{"type":"' +
        type +
        '","question": "' +
        question +
        '","options":' +
        quotedOptions.toString() +
        ',"correctAnswer": "' +
        correctAnswer +
        '"}';
  }
}
