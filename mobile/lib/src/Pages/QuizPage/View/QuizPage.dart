import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/GradesPage/View/GradesQuizSpecificsPage.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonInformationPage.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/AnswerController.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuestionPageController.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/AnswerPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuestionPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/View/QuestionPage.dart';
import 'package:momentum/momentum.dart';

//TODO when click dropdown option, model gets updated with opton pick. the model.update rebuiilds the widget
// https://www.xamantra.dev/momentum/#/router
//"STATE MANAGEMTN"https://github.com/xamantra/momentum/issues/17#issuecomment-656696841

// class used to pass parameters between pages, naemly the lesson page and quiz page
// so that the quizzes for that specific lesson can be displayed
class QuizParam extends RouterParam {
  int lessonId;
  bool showAnswers;
  QuizParam(this.lessonId, this.showAnswers);
}

// when page re-routes back to this page with all the answers, answers are passed as parameters
class AnswerParam extends RouterParam {
  bool displayAnswers = false;
  List<Answer> answers;
  List<String?> correctAnswer;
  AnswerParam(this.displayAnswers, this.answers, this.correctAnswer);
}

class QuizPage extends StatefulWidget {
  QuizPage({
    Key? key,
  }) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends MomentumState<QuizPage> {
  // Everything asssociated with quiz initialised with model and controller when page loads
  // ans state is initliased
  late var quizParam;
  late QuizController quizController;
  late var answerParam;
  late AnswerController answerController;

  late List<Quiz> listOfQuizzes;
  late List<Question> listOfQuestions;
  late List<String> listOfOptions;
  late List<int> listOfQuizIds;
  late List<int> listOfQuestionIds;

  late bool showAnswers;
  late int lessonId;
  late int quizId;
  late int questionId;

  // Number of quizzes = number of tabs
  late int noOfQuizzes;
  // Number of questions = number of tab views
  late int noOfQuestions;

  //Stores answers that can be passed as parameters among pages using RouterParam
  late List<Answer> _selectedAnswers;
  late List<String?> _correctAnswers;
  List<Answer> tempAnswer = [];
  late AnswerPageModel answerModel;

  late bool isClicked;
  @override
  void initMomentumState() {
    super.initMomentumState();

    // Required for momentum state management
    answerController = Momentum.controller<AnswerController>(context);
    quizController = Momentum.controller<QuizController>(context);
    quizParam = MomentumRouter.getParam<QuizParam>(context);
    lessonId = quizParam!.lessonId;
    showAnswers = quizParam!.showAnswers;
    quizController.getQuizzes(lessonId);
    answerParam = MomentumRouter.getParam<AnswerParam>(context);

    // Inititalising all values
    listOfQuizzes = []; // temp array
    listOfQuestions = [];
    listOfOptions = [];
    _correctAnswers = [];
    listOfQuizIds = [];
    listOfQuestionIds = [];
    noOfQuizzes = 0;
    noOfQuestions = 0;
    _selectedAnswers = [];
    _correctAnswers = [];
    quizId = 0;
    questionId = 0;
    isClicked = false;
  }

  @override
  Widget build(BuildContext context) {
    MomentumBuilder _momentumBuilder = MomentumBuilder(
        controllers: [QuizController, AnswerController],
        builder: (context, snapshot) {
          // Get the list of quizzes so that I can dynamically edit UI
          final quizzes = snapshot<QuizPageModel>();
          var allQuizzes = {
            for (var quiz in quizzes.quizes) quiz.id: quiz.questions
          };
          noOfQuizzes = allQuizzes.length;
          // Error handling
          if (noOfQuizzes <= 0) {
            return SpinKitCircle(
              color: Colors.black,
            );
          }
          //use maps to maintain id and value, which are both needed to answer quiz: https://dev.to/javasampleapproach/dart-flutter-map-tutorial-create-add-delete-iterate-sorting-5e82
          // Get the list of questions and answers so that I can dynamically edit UI
          var allQuestionTypes;
          allQuizzes.entries.forEach((quiz) {
            allQuestionTypes = {for (var q in quiz.value!) q.id: q.type};
          });

          var allQuestions;
          allQuizzes.entries.forEach((quiz) {
            allQuestions = {for (var q in quiz.value!) q.id: q.question};
          });

          var allOptionalAnswers;
          allQuizzes.entries.forEach((quiz) {
            allOptionalAnswers = {for (var q in quiz.value!) q.id: q.options};
          });

          var allCorrectAnswers; //Map<int, String> allCorrectAnswers
          allQuizzes.entries.forEach((quiz) {
            allCorrectAnswers = {
              for (var q in quiz.value!) q.id: q.correctAnswer
            };
          });

          // print(allQuestionTypes);
          // print(allQuestions);
          //print(allOptionalAnswers);
          print(allCorrectAnswers);

          // Create numbered tabs whereby each number represents a quiz
          // allowing the student to toggle between quizzes
          List<Widget> tabs = [];
          for (int i = 0; i < noOfQuizzes; i++) {
            tabs.add(Tab(
              text: (i + 1).toString(),
            ));
          }

          // Dynamically create widgets that contain quiz and questions information
          // so that widgets holding this content can be displayed dynamically
          List<Widget> dropdowns = [];

          // For each and every quiz, each identified by it's key (aka id), add information
          // to the list of widgets
          allQuizzes.entries.forEach((quiz) {
            // For each list of dropdowns create a set of option items to select from
            allOptionalAnswers.forEach((int questionId, List<String> value) {
              print('here we go again');
              answerController.updateAnswer(value[0]);
              answerModel = snapshot<AnswerPageModel>();
              //print('initial: ' + answerModel.answer);
              dropdowns.add(new DropdownButton<String?>(
                  value: answerModel.answer,
                  items: value.map((String option) {
                    return DropdownMenuItem<String>(
                      child: new Text(option),
                      value: option,
                    );
                  }).toList(),
                  onChanged: (selectedValue) {
                    print('selected: ' + selectedValue!);
                    print('prev: ' + answerModel.answer);
                    _selectedAnswers.add(Answer(questionId, selectedValue));
                    answerController.updateAnswer(selectedValue);
                    answerModel = snapshot<AnswerPageModel>();
                    print('after: ' + answerModel.answer);
                  }));
            });

            dropdowns.add(
              ElevatedButton(
                onPressed: () {
                  print('lessonId: ' + lessonId.toString());
                  print('quizId: ' + quiz.key.toString());
                  print('selected answer: ' + _selectedAnswers.toString());
                  //TODO can only submit quiz once, so when I'm sure submit
                  //quizController.answerQuizByLessonId(lessonId, quizId, _selectedAnswers);
                  MomentumRouter.goto(
                    context,
                    QuizPage,
                    params: QuizParam(lessonId, true),
                  );
                },
                child: const Text('Submit Answers'),
              ),
            );

            if (showAnswers == true) {
              dropdowns
                  .add(Text('Correct answers' + allCorrectAnswers.toString()));
            }
          });
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 20.0),
                // Structure of tabs: how many tabs
                DefaultTabController(
                  length: noOfQuizzes,
                  initialIndex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Add UI pazzazz to tab bar: how tabs are labeled
                      Container(
                        child: TabBar(
                          labelColor: Colors.green,
                          unselectedLabelColor: Colors.black,
                          tabs: tabs,
                        ),
                      ),
                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: dropdowns,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
    //Display page
    return MobilePageLayout(false, false, _momentumBuilder, 'Quizzes');
  }
}
