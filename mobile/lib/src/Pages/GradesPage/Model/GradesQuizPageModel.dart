import 'package:mobile/src/Pages/GradesPage/Controller/GradesQuizPageController.dart';
import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';
import 'package:momentum/momentum.dart';

class GradesQuizPageModel extends MomentumModel<GradesQuizPageController> {
  GradesQuizPageModel(GradesQuizPageController controller, this.quizList) : super(controller);

  final List<Quiz> quizList;

  @override
  void update({List<Quiz>? quizList}) {
    GradesQuizPageModel(controller, quizList ?? this.quizList).updateMomentum();
  }

}