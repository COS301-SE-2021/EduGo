import 'package:mobile/src/Pages/QuizPage/Controller/AnswerController.dart';
import 'package:momentum/momentum.dart';

class AnswerModel extends MomentumModel<AnswerController> {
  AnswerModel(AnswerController controller, {required this.checkArray})
      : super(controller);

//List of quizzes to return
  final List<bool> checkArray;

  //Used by mvc momentum to update Quizsubject model
  @override
  void update({List<bool>? checkArray}) {
    AnswerModel(controller, checkArray: checkArray ?? this.checkArray)
        .updateMomentum();
  }

  List<bool> getCheckArray() {
    return checkArray;
  }

  void init() {
    for (int i = 0; i < 4; i++) {
      checkArray[i] = false;
    }
  }
}
