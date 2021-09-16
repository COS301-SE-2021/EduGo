import 'package:mobile/src/Pages/QuizPage/Model/Data/Quiz.dart';

class Quizzes {
  final int lessonId;
  final List<Quiz> quizzes;

  Quizzes({required this.quizzes, required this.lessonId});

  factory Quizzes.fromJson(dynamic quizzesJson, int lessonId) {
    var list = quizzesJson['data'] as List;

    List<Quiz> quizzesList = list
        .map(
          (quiz) => Quiz.fromJson(quiz, lessonId),
        )
        .toList();
    return Quizzes(quizzes: quizzesList, lessonId: lessonId);
  }
}
