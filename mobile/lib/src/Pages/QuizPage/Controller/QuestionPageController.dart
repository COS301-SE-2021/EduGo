import 'package:mobile/src/Pages/QuizPage/Model/QuestionPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:momentum/momentum.dart';

class QuestionPageController extends MomentumController<QuestionPageModel> {
  QuestionPageController({this.mock = false});
  bool mock;

  // Used to get the question details in the list of questions at this index
  int index = 0;

  @override
  QuestionPageModel init() {
    return QuestionPageModel(
      this,
      type: QuestionType.TrueFalse,
      questionText: '',
      optionsText: [],
      correctAnswer: '',
    );
  }

  // Update the question details based on the list passed in. Move onto the
  // next question and keep the enabled or disable at the last question.
  bool updateQuestionDetails(List<Question>? questions) {
    //all but last question
    if (index < questions!.length - 1) {
      model.update(question: questions.elementAt(index));
    }
    //last question
    if (index == questions.length - 1) {
      return false;
    }
    index++;
    return true;
  }
}
