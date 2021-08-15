import 'package:mobile/src/Pages/QuizPage/Model/QuizPageModel.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:momentum/momentum.dart';

class QuestionController extends MomentumController<QuestionModel> {
  int i = 0;

  @override
  QuestionModel init() {
    return QuestionModel(
      this,
      //default values fot wehn model is initialised
      type: questions.elementAt(i).type,
      questionText: questions.elementAt(i).questionText,
      optionsText: questions.elementAt(i).optionsText,
      correctAnswer: questions.elementAt(i).correctAnswer,
    );
  }

  bool isNextQuestionRetrievable(List<Question> questions) {
    //all but last question
    if (i < questions.length - 1) {
      i++;
      Question currentQuestion = questions.elementAt(i);
      model.update(
          type: currentQuestion.type,
          questionText: currentQuestion.questionText,
          optionsText: currentQuestion.optionsText,
          correctAnswer: currentQuestion.correctAnswer);
    }
    //last question
    if (i == questions.length - 1) {
      return false;
    }
    return true;
  }
}
