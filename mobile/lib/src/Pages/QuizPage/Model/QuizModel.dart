import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:momentum/momentum.dart';

//for the page
class QuizModel extends MomentumModel<QuizController> {
  QuizModel(
    QuizController controller, {
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  }) : super(controller);

  final int id;
  final String title;
  final String description;
  final List<Question> questions;

  @override
  void update({
    int? id,
    String? title,
    String? description,
    List<Question>? questions,
  }) {
    QuizModel(
      controller,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      questions: questions ?? this.questions,
    ).updateMomentum();
  }
}
