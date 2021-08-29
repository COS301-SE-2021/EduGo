import 'package:mobile/src/Pages/QuizPage/Controller/AnswerController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:momentum/momentum.dart';

class AnswerPageModel extends MomentumModel<AnswerController> {
  AnswerPageModel(
    AnswerController controller, {
    required this.answer,
  }) : super(controller);

  // final int? lessonId;
  // final int? quiz_id;
  // final List<Answer>? answers;
  final String answer;

  @override
  void update({
    String? answer,
  }) {
    print(answer ?? this.answer);
    AnswerPageModel(
      controller,
      answer: answer ?? this.answer,
    ).updateMomentum();
  }
}
