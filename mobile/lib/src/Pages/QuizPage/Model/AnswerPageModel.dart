import 'package:mobile/src/Pages/QuizPage/Controller/AnswerController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:momentum/momentum.dart';

class AnswerPageModel extends MomentumModel<AnswerController> {
  AnswerPageModel(
    AnswerController controller, {
    required this.lessonId,
    required this.quiz_id,
    required this.answers,
  }) : super(controller);

  final int? lessonId;
  final int? quiz_id;
  final List<Answer>? answers;

  @override
  void update({List<Answer>? quizes}) {
    AnswerPageModel(controller,
            lessonId: lessonId ?? this.lessonId,
            quiz_id: quiz_id ?? this.quiz_id,
            answers: answers ?? this.answers)
        .updateMomentum();
  }
}
