import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizzesPageController.dart';
import 'Data/Quiz.dart';
import 'package:mobile/src/Pages/QuizPage/View/Widgets/QuestionCard.dart';

class QuizzesPageModel extends MomentumModel<QuizzesPageController> {
  final List<Quiz> lessonQuizzes;
  final Quiz currentQuiz;
  final List<Widget> quizzesView;
  final QuestionCard currentQuestion;
  final int lessonId;
  final int questionCount;
  final String currentAnswer;
  final List<int> answeredQuizzes;

  QuizzesPageModel(
    QuizzesPageController controller, {
    required this.lessonQuizzes,
    required this.currentAnswer,
    required this.currentQuiz,
    required this.answeredQuizzes,
    required this.quizzesView,
    required this.lessonId,
    required this.questionCount,
    required this.currentQuestion,
  }) : super(controller);

  @override
  void update(
      {List<Quiz>? lessonQuizzes,
      Quiz? currentQuiz,
      List<Widget>? quizzesView,
      int? lessonId,
      int? questionCount,
      QuestionCard? currentQuestion,
      String? currentAnswer,
      List<int>? answeredQuizzes}) {
    QuizzesPageModel(controller,
            currentAnswer: currentAnswer ?? this.currentAnswer,
            lessonQuizzes: lessonQuizzes ?? this.lessonQuizzes,
            currentQuiz: currentQuiz ?? this.currentQuiz,
            quizzesView: quizzesView ?? this.quizzesView,
            questionCount: questionCount ?? this.questionCount,
            lessonId: lessonId ?? this.lessonId,
            currentQuestion: currentQuestion ?? this.currentQuestion,
            answeredQuizzes: answeredQuizzes ?? this.answeredQuizzes)
        .updateMomentum();
  }
}
