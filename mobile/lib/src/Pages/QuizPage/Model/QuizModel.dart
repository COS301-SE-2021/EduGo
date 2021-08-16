import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:momentum/momentum.dart';

//for the page
class QuizModel extends MomentumModel<QuizController> {
  QuizModel(
    QuizController controller, {
    required this.questions,
  }) : super(controller);

  final List<Question> questions;

  @override
  void update({List<Question>? questions}) {
    QuizModel(
      controller,
      questions: questions ?? this.questions,
    ).updateMomentum();
  }
}
