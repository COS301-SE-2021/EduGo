import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:momentum/momentum.dart';

class QuizPageModel extends MomentumModel<QuizController> {
  QuizPageModel(
    QuizController controller, {
    required this.quizes,
  }) : super(controller);

  final List<Quiz> quizes;

  @override
  void update({List<Quiz>? quizes}) {
    QuizPageModel(controller, quizes: quizes ?? this.quizes).updateMomentum();
  }
}
