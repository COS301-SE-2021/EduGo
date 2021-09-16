import 'package:mobile/src/Pages/QuizPage/Model/Data/Question.dart';

class Quiz {
  int _id;
  int _numQuestions;
  List<Question> _questions;

  Quiz({
    required int id,
    required int lessonId,
    required List<Question> questions,
    required int numQuestions,
  })  : _id = id,
        _questions = questions,
        _numQuestions = numQuestions;

  int getId() {
    return _id;
  }

  int getNumQuestions() {
    return _numQuestions;
  }

  List<Question> getQuestions() {
    return _questions;
  }

  factory Quiz.fromJson(Map<String, dynamic> json, int lessonId) {
    var list = json['questions'] as List;

    List<Question> questionsList = list
        .map(
          (question) => Question.fromJson(question),
        )
        .toList();

    int numQ = questionsList.length;
    return Quiz(
        id: json['id'] as int,
        questions: questionsList,
        numQuestions: numQ,
        lessonId: lessonId);
  }

  List<Map<String, dynamic>> getAnswersJson() {
    List<Map<String, dynamic>> _answers = [];
    _questions.forEach(
      (question) {
        _answers.add(
          question.toJson(),
        );
      },
    );
    return _answers;
  }
}
