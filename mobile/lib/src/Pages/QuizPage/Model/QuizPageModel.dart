import 'package:mobile/src/Pages/QuizPage/Controller/QuizPageController.dart';
import 'package:momentum/momentum.dart';

class QuizPageModel extends MomentumModel<QuizPageController> {
  QuizPageModel(QuizPageController controller) : super(controller);

  // TODO: add your final properties here...

  @override
  void update() {
    QuizPageModel(
      controller,
    ).updateMomentum();
  }
}
