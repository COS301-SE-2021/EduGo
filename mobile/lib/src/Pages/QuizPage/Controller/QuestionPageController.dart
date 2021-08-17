import 'package:mobile/src/Pages/QuizPage/Model/QuestionPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:momentum/momentum.dart';

class QuestionPageController extends MomentumController<QuestionPageModel> {
  QuestionPageController({this.mock = false});
  bool mock;

  QuestionPageModel init() {
    return QuestionPageModel(
      this,
      type: QuestionType.TrueFalse,
      questionText: '',
      optionsText: [],
      correctAnswer: '',
    );
  }
}
