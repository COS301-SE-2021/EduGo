import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';
import 'package:momentum/momentum.dart';

class GradesQuizPageParam extends RouterParam {
  final List<Quiz> quizList;

  GradesQuizPageParam({required this.quizList});
}