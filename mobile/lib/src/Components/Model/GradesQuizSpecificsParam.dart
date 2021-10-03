import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';
import 'package:momentum/momentum.dart';

class GradesQuizSpecificsParam extends RouterParam {
  final List<QuizAnswers> quizAnswers;

  GradesQuizSpecificsParam({required this.quizAnswers});
}