import 'package:mobile/src/Pages/QuizPage/Model/QuestionPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:momentum/momentum.dart';

class QuestionPageController extends MomentumController<QuestionPageModel> {
  bool mock;
  QuestionPageController({this.mock = false});

  QuestionPageModel init() {
    int index = 0;
    return QuestionPageModel(
      this,
      type: QuestionType.TrueFalse,
      questionText: '',
      optionsText: [],
      correctAnswer: '',
    );
  }

  Future<void> loadQuestion(List<Question> questions) async {
    model.update(
        //question: questions.elementAt(index).question,
        );
  }
}
