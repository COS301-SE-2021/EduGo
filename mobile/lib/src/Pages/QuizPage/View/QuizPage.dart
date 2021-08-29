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
  QuizParam(this.lessonId);
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

  @override
  void initMomentumState() {
    super.initMomentumState();

    // Required for momentum state management
    answerController = Momentum.controller<AnswerController>(context);
    quizController = Momentum.controller<QuizController>(context);
    quizParam = MomentumRouter.getParam<QuizParam>(context);
    lessonId = quizParam!.lessonId;
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

          print(allQuestionTypes);
          print(allQuestions);
          print(allOptionalAnswers);
          print(allCorrectAnswers);

          // Create numbered tabs whereby each number represents a quiz
          // allowing the student to toggle between quizzes
          List<Widget> tabs = [];
          for (int i = 0; i < noOfQuizzes; i++) {
            tabs.add(Tab(
              text: (i + 1).toString(),
            ));
          }

          //Dynamically create dropdown so options can be displayed dynamically
          List<Widget> dropdowns = [];

          allOptionalAnswers.values.forEach((List<String> v) {
            answerController.updateAnswer(v[0]);
            var answerModel = snapshot<AnswerPageModel>();
            print('initial: ' + answerModel.answer);
            dropdowns.add(new DropdownButton<String?>(
                value: answerModel.answer,
                items: v.map((String option) {
                  return DropdownMenuItem<String>(
                    child: new Text(option),
                    value: option,
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  setState(() {
                    print('prev: ' + answerModel.answer);
                    answerController.updateAnswer(selectedValue);
                    print('after: ' + answerModel.answer);
                  });
                }));
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

/**
 import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonInformationPage.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuestionPageController.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuestionPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/View/QuestionPage.dart';
import 'package:momentum/momentum.dart';

class QuizPage extends StatefulWidget {
  QuizPage({
    Key? key,
  }) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState();
}

class QuizParam extends RouterParam {
  final int lessonId;
  QuizParam(this.lessonId);
}

class _QuizPageState extends State<QuizPage> {
  _QuizPageState();

  // Number of quizModel = number of tabs
  late int noOfQuizzes;
  // Number of questions = number of tab views
  late int noOfQuestions;
  // Will hold a List of questions for each quiz in the total noOfQuizzzes
  late List<Quiz> listOfQuizzes;
  //Stores answers that can be passed as parameters among pages using RouterParam
  late List<Answer> _selectedAnswers;
  late List<String?> _correctAnswers;
  // End quiz button
  late int lessonId;
  late int quizId;
  late int questionId;

  @override
  void initState() {
    super.initState();
    listOfQuizzes = [];
    noOfQuizzes = 0;
    noOfQuestions = 0;
    _selectedAnswers = [];
    _correctAnswers = [];
    lessonId = 0;
    quizId = 0;
    questionId = 0;
  }

  @override
  Widget build(BuildContext context) {
    final quizParam = MomentumRouter.getParam<QuizParam>(context);
    late var quizController;

    // Create numbered tabs
    List<Widget> _buildTabs(int noOfQuizzes) {
      List<Widget> tabs = [];
      for (int i = 0; i < noOfQuizzes; i++) {
        tabs.add(Tab(
          text: (i + 1).toString(),
        ));
      }
      return tabs;
    }

    // Add UI pazzazz to tab bar
    Widget _getTabBarDecor() {
      Widget tabBarDecor = Container(
        child: TabBar(
          labelColor: Colors.green,
          unselectedLabelColor: Colors.black,
          tabs: _buildTabs(noOfQuizzes),
        ),
      );
      return tabBarDecor;
    }

    // View of questions
    TabBarView _buildTabBarView() {
      // content body displayed for a particular tab so that content can be dynamically added
      TabBarView _tabBarView = TabBarView(children: <Widget>[]);
      // For loop below dynamically disyplays ALL THE QUESTIONS of a quiz in
      // the LIST at a particular index
      for (int i = 0; i < noOfQuizzes; i++) {
        // Questions contents to be diplsayed on the view. The lists below are
        // iterated later for contents of a specific question.
        List<Question> questions =
            List.from(listOfQuizzes.elementAt(i).questions!);

        //Dynamically create dropdown so options can be displayed dynamically
        List<String>? _options = questions.elementAt(i).options;
        String? _selectedOption;
        print("selected:" + _options!.first);
        Widget dynamicDropdown = DropdownButton(
          hint: Text('Please choose an answer'),
          value: _selectedOption,
          onChanged: (String? newValue) {
            setState(() {
              _selectedOption = newValue;
              print("selected:" + newValue!);
            });
          },
          items: _options!.map((option) {
            return DropdownMenuItem(
              child: new Text(option),
              value: option,
            );
          }).toList(),
        );

        _tabBarView.children.add(dynamicDropdown);
      }

      return _tabBarView;
      /*TabBarView _tabBarView = TabBarView(children: <Widget>[]);
      // For loop below dynamically disyplays ALL THE QUESTIONS of a quiz in
      // the LIST at a particular index
      for (int i = 0; i < noOfQuizzes; i++) {
        // Questions contents to be diplsayed on the view. The lists below are
        // iterated later for contents of a specific question.
        List<Question> questions =
            List.from(listOfQuizzes.elementAt(i).questions!);
        List<Widget> columnWidget = [];
        columnWidget.add(Padding(padding: const EdgeInsets.only(top: 50.0)));
        // For each question in the quiz, create the widgets so thatt they may be
        // added to the view
        List<Widget> getColumnWidget(int noOfQsforThisQuiz) {
          for (int q = 0; q < questions.length; q++) {
            // Questions to be asked
            columnWidget.add(Text(questions.elementAt(q).question));

            // Optional answers: iterarting through all the options of this particular
            // question so that I may create a UI widget that a student may select
            List<String> optionalAnswers =
                List.from(questions.elementAt(q).options!);
            String? _value = '';
            for (var optionalAnswer in optionalAnswers) {
              if (questions.elementAt(q).type == QuestionType.TrueFalse) {
                columnWidget.add(ChoiceChip(
                  selectedColor: Colors.green,
                  backgroundColor: Colors.grey,
                  label: Text(optionalAnswer),
                  labelStyle: TextStyle(color: Colors.white),
                  selected: _value == optionalAnswer,
                  onSelected: (bool selected) {
                    setState(() {
                      //TODO fix does not change color
                      _value = selected ? optionalAnswer : 'N/A';

                      // Selected answer of each question
                      _selectedAnswers.add(new Answer(
                          listOfQuizzes.elementAt(i).questions!.elementAt(q).id,
                          optionalAnswer));
                    });
                  },
                ));
              } else if (questions.elementAt(q).type ==
                  QuestionType.MultipleChoice) {
                //questions.elementAt(q).id
                columnWidget.add(FilterChip(
                    label: Text(optionalAnswer),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: Colors.grey,
                    selected: _value == optionalAnswer,
                    selectedColor: Colors.green,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? optionalAnswer : 'N/A';

                        // Selected answer of each question
                        _selectedAnswers.add(new Answer(
                            listOfQuizzes
                                .elementAt(i)
                                .questions!
                                .elementAt(q)
                                .id,
                            optionalAnswer));
                      });
                    }));
              }
            }
            //Space between all questions
            columnWidget
                .add(Padding(padding: const EdgeInsets.only(top: 25.0)));
          }
          //End quiz aka section of quizModel button
          columnWidget.add(
            // Button to sumbit quiz placed outside the loop as it is only displayed at
            // the end of the page not after each and every question
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
              child: ElevatedButton(
                onPressed: () {
                  quizController.answerQuizByLessonId(
                      listOfQuizzes.elementAt(i).id, _selectedAnswers);
                  MomentumRouter.goto(
                    context,
                    LessonInformationPage,
                  );
                },
                child: const Text('Submit Answers'),
              ),
            ),
          ); //endQuizBtn());

          return columnWidget;
        }

        // Adding all the contents we gathered in a neat display by calling the function
        _tabBarView.children.add(
          Container(
            child: Scrollbar(
              // isAlwaysShown: true, //TODO wants a controller ugh
              child: new SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: getColumnWidget(questions.length),
                ),
              ),
            ),
          ),
        );
      }

      return _tabBarView;
    */
    }

    // Add UI pazzazz to view
    Widget _getTabBarViewDecor() {
      Widget _tabBarViewDecor = Container(
          height:
              400, //height of TabBarView //TODO might have to use frationally sized box
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
          child: _buildTabBarView());
      return _tabBarViewDecor;
    }

    // Structure of tabs
    DefaultTabController _getDefaultTabController() {
      DefaultTabController _defaultTabController = DefaultTabController(
          length: noOfQuizzes,
          initialIndex: 0,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[_getTabBarDecor(), _getTabBarViewDecor()]));
      return _defaultTabController;
    }

    // The contents of the screen
    Widget _getChild() {
      Widget child = Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20.0),
              _getDefaultTabController(),
            ]),
      );
      return child;
    }

    MomentumBuilder _momentumBuilder = MomentumBuilder(
        controllers: [QuizController, QuestionPageController],
        builder: (context, snapshot) {
          // Get the list of quizzes so that I can dynamically edit UI
          final quizModel = snapshot<QuizPageModel>();
          quizController = Momentum.controller<QuizController>(context);

          //lessonId passed from lesson page to get the quizzes for that lesson
          lessonId = quizParam!.lessonId;
          quizController.getQuizzes(lessonId);
          noOfQuizzes = quizModel.quizes.length;

          //temporarily store list of quizzzes instead of
          listOfQuizzes = List.from(quizModel.quizes);
          return _getChild(); //empty row as builder interferes with other components that don't make use of MVC
        });

    //Display page
    return MobilePageLayout(false, false, _momentumBuilder, 'Quizzes');
  }
}

 */
