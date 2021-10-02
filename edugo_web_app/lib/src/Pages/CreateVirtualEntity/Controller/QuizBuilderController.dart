import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/Model/Data/QuestionObject.dart';
import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/CreateVirtualEntityWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class QuizBuilderController extends MomentumController<QuizBuilderModel> {
  @override
  QuizBuilderModel init() {
    return QuizBuilderModel(this, quizBuilderViewComponents: [], questions: []);
  }

  bool validateQuiz(GlobalKey<FormState> quizFormKey) {
    bool returnBool = true;
    if (model.questions.isEmpty) {
      return false;
    }
    model.questions.forEach(
      (question) {
        if (question.correctAnswer.isEmpty ||
            question.options.isEmpty ||
            question.question.isEmpty) {
          quizFormKey.currentState.validate();
          returnBool = false;
          return false;
        }
        if (question.type == "FillinMissingWord") {
          if (question.words.isEmpty || question.sentences.isEmpty) {
            quizFormKey.currentState.validate();
            returnBool = false;
            return false;
          }
        }
        if (question.type == "ImageQuestion") {
          if (question.options.isEmpty ||
              question.question.isEmpty ||
              question.imageLink.isEmpty) {
            quizFormKey.currentState.validate();
            returnBool = false;
            return false;
          }
        }
      },
    );
    return returnBool;
  }

  void inputQuestionType(String type, int id) {
    model.setQuestionType(type, id);
  }

  List<Widget> buildQuizBuilderView() {
    return model.getQuizBuilderView();
  }

  void setMissingWords(questionId, wordCount) {
    List<QuestionObject> tempQuestions = model.questions;
    if (tempQuestions[questionId].words.isNotEmpty &&
        wordCount < model.questions[questionId].missingWordCount) {
      tempQuestions[questionId].words.removeLast();
      if (tempQuestions[questionId].sentences.isNotEmpty &&
          tempQuestions[questionId].sentences.length >
              model.questions[questionId].missingWordCount)
        tempQuestions[questionId].sentences.removeLast();
    }
    tempQuestions[questionId].missingWordCount = wordCount;
    model.update(questions: tempQuestions);
  }

  void setFormKey(GlobalKey<FormState> createQuizFormKey) {
    model.update(createQuizFormKey: createQuizFormKey);
  }

  GlobalKey<FormState> getFormKey() {
    return model.createQuizFormKey;
  }

  Widget buildQuizBuilderOptionView(int questionId) {
    return Column(children: model.getOptionsView(questionId));
  }

  List<Widget> buildQuizBuilderSentenceView(int questionId) {
    int id = 0;
    List<Widget> tempComponents = <Widget>[];
    model.questions[questionId].sentences.forEach(
      (sentence) {
        tempComponents.add(
          new QuizBuilderOption(
            width: 600,
            questionId: questionId,
            optionId: id,
            optionValue: sentence,
            onDelete: (questionId, sentenceId) {
              removeSentence(questionId: questionId, sentenceId: sentenceId);
            },
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

  List<Widget> buildQuizBuilderWordView(int questionId) {
    int id = 0;
    List<Widget> tempComponents = <Widget>[];
    model.questions[questionId].words.forEach(
      (word) {
        tempComponents.add(
          new QuizBuilderOption(
            width: 600,
            questionId: questionId,
            optionId: id,
            optionValue: word,
            onDelete: (questionId, wordId) {
              removeWord(questionId: questionId, wordId: wordId);
            },
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

  void inputQuestion({String question, int questionId}) {
    model.setQuestion(question, questionId);
  }

  void newQuestion() {
    model.newQuestion();
  }

  String getSentence(questionId) {
    return model.questions[questionId].makeSentence();
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

  void newWord(context, {int questionId}) {
    if (model.questions[questionId].words.length <
        model.questions[questionId].missingWordCount) {
      if (model.questions[questionId].currentWordInput != null &&
          model.questions[questionId].currentWordInput != "") {
        List<QuestionObject> tempQuestions = model.questions;
        tempQuestions[questionId]
            .words
            .add(model.questions[questionId].currentWordInput);
        model.update(questions: tempQuestions);
      }
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            insetPadding:
                EdgeInsets.only(top: 100, bottom: 100, left: 100, right: 100),
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
                    'Missing word limit reached.',
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
                      'Increase number of missing words and try again',
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
    }
  }

  void editWord({int questionID, String wordValue}) {
    List<QuestionObject> tempQuestions = model.questions;
    tempQuestions[questionID].currentWordInput = wordValue;
    if (wordValue == null || wordValue == "") return;
    model.update(questions: tempQuestions);
  }

  void newSentence(
    context, {
    int questionId,
  }) {
    if (model.questions[questionId].sentences.length <
        (model.questions[questionId].missingWordCount + 1)) {
      if (model.questions[questionId].currentSentenceInput != null &&
          model.questions[questionId].currentSentenceInput != "") {
        List<QuestionObject> tempQuestions = model.questions;
        tempQuestions[questionId]
            .sentences
            .add(model.questions[questionId].currentSentenceInput);
        model.update(questions: tempQuestions);
      }
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            insetPadding:
                EdgeInsets.only(top: 100, bottom: 100, left: 100, right: 100),
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
                    'Sentence limit reached.',
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
                      'Increase number of missing words and try again',
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
    }
  }

  void removeSentence({int questionId, int sentenceId}) {
    List<QuestionObject> tempQuestions = model.questions;
    tempQuestions[questionId].sentences.removeAt(sentenceId);
    model.update(questions: tempQuestions);
  }

  void removeWord({int questionId, int wordId}) {
    List<QuestionObject> tempQuestions = model.questions;
    tempQuestions[questionId].words.removeAt(wordId);
    model.update(questions: tempQuestions);
  }

  void editSentence({int questionID, String sentenceValue}) {
    List<QuestionObject> tempQuestions = model.questions;
    tempQuestions[questionID].currentSentenceInput = sentenceValue;
    if (sentenceValue == null || sentenceValue == "") return;
    model.update(questions: tempQuestions);
  }

  Map<String, dynamic> getQuizBuilderResult(context) {
    return <String, dynamic>{"questions": model.getQuizBuilderResult(context)};
  }

  void resetQuizBuilder() {
    model.questions.clear();
    model.quizBuilderViewComponents.clear();
  }

  void discardQuestionImage(questionId) {
    List<QuestionObject> tempQuestions = model.questions;
    tempQuestions[questionId].imageLink = "";
    model.update(questions: tempQuestions);
  }

  Future<String> uploadQuestionImage(context, questionId) async {
    List<int> _selectedFile;
    Uint8List _bytesData;

    InputElement uploadInput = FileUploadInputElement();
    uploadInput.accept = '.png,.jpg';
    uploadInput.checkValidity();
    uploadInput.multiple = false;

    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen(
      (e) {
        final files = uploadInput.files;
        final file = files[0];
        final reader = new FileReader();
        if (file.type.contains('image')) {
          reader.readAsDataUrl(file);
          reader.onLoadEnd.listen(
            (e) async {
//*********************************************************************************************
//*                                                                                           *
//*       Handle result of picking file                                                       *
//*                                                                                           *
//*********************************************************************************************

              _bytesData = Base64Decoder()
                  .convert(reader.result.toString().split(",").last);
              _selectedFile = _bytesData;

              var url = Uri.parse(EduGoHttpModule().getBaseUrl() +
                  "/virtualEntity/uploadImage");

              var request = new MultipartRequest(
                "POST",
                url,
              );

              request.headers["authorization"] =
                  Momentum.controller<AdminController>(context).getToken();

              request.files.add(
                MultipartFile.fromBytes('image', _selectedFile,
                    contentType: new MediaType('application', 'octet-stream'),
                    filename: file.name),
              );

              await request.send().then(
                (value) async {
                  await Response.fromStream(value).then(
                    (response) {
                      if (response.statusCode == 200) {
                        Map<String, dynamic> _response =
                            jsonDecode(response.body);
                        String linkToImage = _response['fileLink'];
                        List<QuestionObject> tempQuestions = model.questions;
                        tempQuestions[questionId].imageLink = linkToImage;
                        model.update(questions: tempQuestions);
                      } else {
                        model.questions[questionId].imageLink = "";
                      }
                    },
                  );
                },
              );
            },
          );
        } else {
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
                        'Invalid Image Uploaded',
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
                          'Please upload a ".jpg" or ".png" file and try again!',
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
        }
      },
    );

    return model.questions[questionId].imageLink;
  }
}
