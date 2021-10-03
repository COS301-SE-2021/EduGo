class QuestionObject {
  String question = "";
  String currentOptionInput = "";
  String currentWordInput = "";
  String currentSentenceInput = "";
  int missingWordCount;
  String type = "";
  String correctAnswer = "";
  String imageLink = "";
  List<String> options = [];
  List<String> words = [];
  List<String> sentences = [];

  Map<String, dynamic> toJson() {
    if (type == 'FillinMissingWord') {
      return {
        'question': makeSentence(),
        'type': type,
        'correctAnswer': makeCorrectAnswer(),
        'options': options,
      };
    } else if (type != 'ImageQuestion') {
      return {
        'question': question,
        'type': type,
        'correctAnswer': correctAnswer,
        'options': options,
      };
    } else
      return {
        'question': question,
        'type': type,
        'correctAnswer': correctAnswer,
        'options': options,
        'imageLink': imageLink,
      };
  }

  String makeSentence() {
    String finalSentence = "";
    int length = sentences.length;
    sentences.forEach(
      (sentence) {
        if (length == 1) {
          if (sentences.length == missingWordCount)
            finalSentence += sentence + " _____ ";
          if (sentences.length - missingWordCount == 1)
            finalSentence += sentence + ".";
        } else {
          finalSentence += sentence + " _____ ";
        }
        length--;
      },
    );
    return finalSentence;
  }

  String makeCorrectAnswer() {
    int length = words.length;
    correctAnswer = "";
    words.forEach(
      (word) {
        if (length == 1)
          correctAnswer += word;
        else
          correctAnswer += word + ";";
        length--;
      },
    );
    options = words;
    return correctAnswer;
  }
}
