import 'package:mobile/src/Pages/QuizPage/Controller/QuestionController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:momentum/momentum.dart';

class QuestionModel extends MomentumModel<QuestionController> {
  QuestionModel(
    QuestionController controller, {
    required this.type,
    required this.questionText,
    required this.optionsText,
    required this.correctAnswer,
  }) : super(controller);

  final QuestionType type;
  final String questionText;
  final List<String>? optionsText;
  final String correctAnswer;

  @override
  void update({
    QuestionType? type,
    String? questionText,
    List<String>? optionsText,
    String? correctAnswer,
  }) {
    QuestionModel(
      controller,
      type: type ?? this.type,
      questionText: questionText ?? this.questionText,
      optionsText: optionsText ?? this.optionsText,
      correctAnswer: correctAnswer ?? this.correctAnswer,
    ).updateMomentum();
  }
}
