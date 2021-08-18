import 'package:edugo_web_app/src/Pages/EduGo.dart';

class QuizBuilderController extends MomentumController<QuizBuilderModel> {
  @override
  QuizBuilderModel init() {
    return QuizBuilderModel(
      this,
      quizBuilderViewComponents: [],
      questions: [],
    );
  }

  void inputQuestionType(String type, int id) {
    model.setQuestionType(type, id);
  }

  List<Widget> buildQuizBuilderView() {
    return model.getQuizBuilderView();
  }

  Widget buildQuizBuilderOptionView(int questionId) {
    return Column(children: model.getOptionsView(questionId));
  }

  void inputQuestion({String question, int questionId}) {
    model.setQuestion(question, questionId);
  }

  void newQuestion() {
    model.newQuestion();
  }

  void removeQuestion(int id) {
    model.removeQuestion(id);
  }

  void inputCorrectAnswer(String answer, int id) {
    model.setCorrectAnswer(answer, id);
  }

  void removeOption({int questionId, int optionId}) {
    model.removeOption(questionId: questionId, optionId: optionId);
  }

  void newOption({int questionId, String optionValue}) {
    model.newOption(questionId: questionId, optionValue: optionValue);
  }

  void editOption({int questionID, String optionValue}) {
    model.editOption(questionId: questionID, optionValue: optionValue);
  }

  Map<String, dynamic> getQuizBuilderResult() {
    return <String, dynamic>{"questions": model.getQuizBuilderResult()};
  }
}
