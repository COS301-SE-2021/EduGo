import 'package:mobile/src/Pages/QuizPage/Model/QuestionModel.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:momentum/momentum.dart';

class QuestionController extends MomentumController<QuestionModel> {
  QuestionController({this.mock = false});
  bool mock;
  int i = 0;

  @override
  QuestionModel init() {
    return QuestionModel(
      this,
      //default values fot wehn model is initialised
      type: QuestionType.TrueFalse,
      questionText: '',
      optionsText: [],
      correctAnswer: '',
    );
  }

  bool isNextQuestionRetrievable(List<Question> questions) {
    //all but last question
    if (i < questions.length - 1) {
      i++;
      Question currentQuestion = questions.elementAt(i);
      model.update(
          type: currentQuestion.type,
          questionText: currentQuestion.question,
          optionsText: currentQuestion.options,
          correctAnswer: currentQuestion.correctAnswer);
    }
    //last question
    if (i == questions.length - 1) {
      return false;
    }
    return true;
  }
}
