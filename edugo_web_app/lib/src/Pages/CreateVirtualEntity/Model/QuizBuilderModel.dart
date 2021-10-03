import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/Model/Data/QuestionObject.dart';
import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/CreateVirtualEntityWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

// ignore: must_be_immutable
class QuizBuilderModel extends MomentumModel<QuizBuilderController> {
  final List<QuestionObject> questions;
  final List<Widget> quizBuilderViewComponents;
  final String currentMissingWord;
  final String currentSentencePart;
  final GlobalKey<FormState> createQuizFormKey;

  QuizBuilderModel(
    QuizBuilderController controller, {
    this.questions,
    this.currentMissingWord,
    this.currentSentencePart,
    this.quizBuilderViewComponents,
    this.createQuizFormKey,
  }) : super(controller);

  void setQuestionType(String questionType, int id) {
    List<QuestionObject> tempQuestions = questions;
    tempQuestions[id].type = questionType;
    tempQuestions[id].options.clear();
    tempQuestions[id].correctAnswer = "";
    if (questionType == "TrueFalse") {
      tempQuestions[id].options.add("True");
      tempQuestions[id].options.add("False");
      tempQuestions[id].type = "TrueFalse";
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
    tempQuestions[tempQuestions.length - 1].type = "TrueFalse";
    tempQuestions[tempQuestions.length - 1].options.add("True");
    tempQuestions[tempQuestions.length - 1].options.add("False");
    tempQuestions[tempQuestions.length - 1].correctAnswer = "True";
    update(questions: tempQuestions);
    getQuizBuilderView();
  }

  void removeOption({int questionId, int optionId}) {
    List<QuestionObject> tempQuestions = questions;
    tempQuestions[questionId].options.removeAt(optionId);
    if (tempQuestions[questionId].options.length > 0)
      questions[questionId].correctAnswer =
          tempQuestions[questionId].options[0];
    else
      questions[questionId].correctAnswer = null;
    update(questions: tempQuestions);
  }

  void removeWord({int questionId, int wordId}) {
    List<QuestionObject> tempQuestions = questions;
    tempQuestions[questionId].words.removeAt(wordId);
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

  List<Map<String, dynamic>> getQuizBuilderResult(context) {
    List<Map<String, dynamic>> quizBuilderResult = [];
    if (questions.isNotEmpty) {
      questions.forEach(
        (question) {
          if (question.type == "FillinMissingWord" &&
              question.words.length < question.missingWordCount) {
            if (question.sentences.length < question.missingWordCount) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return new AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    insetPadding: EdgeInsets.only(
                        top: 100, bottom: 100, left: 100, right: 100),
                    title: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Icon(
                            Icons.warning_rounded,
                            color: Colors.red,
                            size: 100,
                          ),
                        ),
                        Center(
                          child: new Text(
                            'Not enough sentence parts.',
                            style: TextStyle(fontSize: 22, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    content: new SingleChildScrollView(
                      child: new ListBody(
                        children: [
                          Center(
                            child: new Text(
                              'Add more sentence parts and try again.',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: MaterialButton(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            minWidth: ScreenUtil().setWidth(150),
                            height: 50,
                            child: Text(
                              'Ok',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            color: Color.fromARGB(255, 97, 211, 87),
                            disabledColor: Color.fromRGBO(211, 212, 217, 1),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
              quizBuilderResult = [];
              return quizBuilderResult;
            }
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  insetPadding: EdgeInsets.only(
                      top: 100, bottom: 100, left: 100, right: 100),
                  title: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Icon(
                          Icons.warning_rounded,
                          color: Colors.red,
                          size: 100,
                        ),
                      ),
                      Center(
                        child: new Text(
                          'Not enough missing words.',
                          style: TextStyle(fontSize: 22, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  content: new SingleChildScrollView(
                    child: new ListBody(
                      children: [
                        Center(
                          child: new Text(
                            'Add more missing words and try again.',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: MaterialButton(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          minWidth: ScreenUtil().setWidth(150),
                          height: 50,
                          child: Text(
                            'Ok',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          color: Color.fromARGB(255, 97, 211, 87),
                          disabledColor: Color.fromRGBO(211, 212, 217, 1),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
            quizBuilderResult = [];
            return quizBuilderResult;
          }

          quizBuilderResult.add(
            question.toJson(),
          );
        },
      );
    }

    return quizBuilderResult;
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
        quizFormKey: createQuizFormKey,
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
  void update({
    questions,
    quizBuilderViewComponents,
    createQuizFormKey,
    currentMissingWord,
    currentSentencePart,
  }) {
    QuizBuilderModel(
      controller,
      questions: questions ?? this.questions,
      quizBuilderViewComponents:
          quizBuilderViewComponents ?? this.quizBuilderViewComponents,
      createQuizFormKey: createQuizFormKey ?? this.createQuizFormKey,
      currentMissingWord: currentMissingWord ?? this.currentMissingWord,
      currentSentencePart: currentSentencePart ?? this.currentSentencePart,
    ).updateMomentum();
  }
}
