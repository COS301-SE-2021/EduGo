import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntity/Model/Data/QuestionObject.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntity/View/Widgets/QuestionCard.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntity/View/Widgets/QuestionOptionInputCard.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntity/View/Widgets/QuizBuilderOption.dart';

// ignore: must_be_immutable
class QuizBuilderModel extends MomentumModel<QuizBuilderController> {
  final List<QuestionObject> questions;
  final List<Widget> quizBuilderViewComponents;

  QuizBuilderModel(QuizBuilderController controller,
      {this.questions, this.quizBuilderViewComponents})
      : super(controller);

  void setQuestionType(String questionType, int id) {
    List<QuestionObject> tempQuestions = questions;
    tempQuestions[id].type = questionType;
    tempQuestions[id].options.clear();
    tempQuestions[id].correctAnswer = "";
    if (questionType == "True or False") {
      tempQuestions[id].options.add("True");
      tempQuestions[id].options.add("False");
      tempQuestions[id].type = "True or False";
      tempQuestions[id].correctAnswer = "True";
    }
    update(questions: tempQuestions);
  }

  void newOption({int questionId, String optionValue}) {
    if (optionValue != null && optionValue != "") {
      List<QuestionObject> tempQuestions = questions;
      tempQuestions[questionId].options.add(optionValue);
      tempQuestions[questionId].correctAnswer =
          tempQuestions[questionId].options.elementAt(0);
      update(questions: tempQuestions);
    }
  }

  void editOption({int questionId, String optionValue}) {
    List<QuestionObject> tempQuestions = questions;
    tempQuestions[questionId].currentOptionInput = optionValue;
    if (optionValue == null || optionValue == "") return;
    update(questions: tempQuestions);
    getOptionsView(questionId);
  }

  void newQuestion() {
    List<QuestionObject> tempQuestions = questions;
    tempQuestions.add(new QuestionObject());
    tempQuestions[tempQuestions.length - 1].type = "True or False";
    tempQuestions[tempQuestions.length - 1].options.add("True");
    tempQuestions[tempQuestions.length - 1].options.add("False");
    tempQuestions[tempQuestions.length - 1].correctAnswer = "True";
    update(questions: tempQuestions);
    getQuizBuilderView();
  }

  void removeOption({int questionId, int optionId}) {
    List<QuestionObject> tempQuestions = questions;
    tempQuestions[questionId].options.removeAt(optionId);
    update(questions: tempQuestions);
  }

  List<Widget> getOptionsView(int questionId) {
    int id = 0;
    List<Widget> tempComponents = <Widget>[];

    questions[questionId].options.forEach(
      (option) {
        tempComponents.add(
          new QuizBuilderOption(
            questionId: questionId,
            optionId: id,
            optionValue: option,
          ),
        );
        tempComponents.add(
          SizedBox(
            height: 20,
          ),
        );
        id++;
      },
    );

    return tempComponents;
  }

  void setCorrectAnswer(String answer, id) {
    List<QuestionObject> tempQuestions = questions;
    tempQuestions[id].correctAnswer = answer;
    update(questions: tempQuestions);
  }

  void removeQuestion(int id) {
    List<QuestionObject> tempQuestions = questions;
    tempQuestions.removeAt(id);
    update(questions: tempQuestions);
    getQuizBuilderView();
  }

  void setQuestion(String question, int id) {
    List<QuestionObject> tempQuestions = questions;
    tempQuestions[id].question = question;
    update(questions: tempQuestions);
  }

  void setAnswer(String answer, int id) {
    List<QuestionObject> tempQuestions = questions;
    tempQuestions[id].correctAnswer = answer;
    update(questions: tempQuestions);
  }

  String getQuizBuilderResult() {
    List<String> quizBuilderResult = [];
    String retString;
    if (questions.isNotEmpty) {
      questions.forEach(
        (question) {
          if (question.questionToString() != "Quiz is not valid") {
            quizBuilderResult.add(
              question.questionToString(),
            );
          } else
            retString = "Quiz is not valid";
          return retString;
        },
      );
      if (retString == "Quiz is not valid") return retString;
      return '{"questions:"' + quizBuilderResult.toString() + "}";
    } else
      return "Quiz is not valid";
  }

  List<Widget> getQuizBuilderView() {
    int id = 0;
    List<Widget> tempComponents = <Widget>[];
    questions.forEach((question) {
      tempComponents.add(new QuestionCard(
        questionId: id,
        question: question.question,
        questionType: question.type,
        questionOptions: question.options,
      ));
      tempComponents.add(SizedBox(
        height: 30,
      ));
      id++;
    });
    update(quizBuilderViewComponents: tempComponents);
    return quizBuilderViewComponents;
  }

  @override
  void update({questions, quizBuilderViewComponents}) {
    QuizBuilderModel(controller,
            questions: questions ?? this.questions,
            quizBuilderViewComponents:
                quizBuilderViewComponents ?? this.quizBuilderViewComponents)
        .updateMomentum();
  }
}
