import 'package:flutter/material.dart';
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
class QuizPage extends StatefulWidget {
  //final int lessonId;
  QuizPage({
    Key? key,
    /*required this.lessonId*/
  }) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState(/*lessonId: this.lessonId*/);
}

class QuizParam extends RouterParam {
  int lessonId;
  QuizParam(this.lessonId);
}

class _QuizPageState extends State<QuizPage> {
  //final int lessonId;
  _QuizPageState();
  //_QuizPageState({required this.lessonId});

  // Number of quizzes = number of tabs
  late int noOfQuizzes; //TODO get no of quizzes via controller
  // Number of questions = number of tab views
  late int noOfQuestions; //TODO get no of questions via controller
  // Will hold a List of questions for each quiz in the total noOfQuizzzes
  late List<Quiz> listOfQuizzes;
  //Stores answers that can be passed as parameters among pages using RouterParam
  late List<Answer> _selectedAnswers;
  late List<String?> _correctAnswers;
  // everything associated with quiz
  late int lessonId;
  late int quizId;
  late int questionId;
  //late AnswerController answerController;
  //late AnswerPageModel answerModel;
  List<Answer> tempAnswer = [];

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
    final param = MomentumRouter.getParam<QuizParam>(context);
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
      TabBarView _tabBarView = TabBarView(children: <Widget>[]);
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
            List<String> _options = List.from(questions.elementAt(q).options!);
            _options.insert(0, "Please select answer");
            //String key = answerModel.answers!.elementAt(q).answer
            //Dynamically create dropdown so options can be displayed dynamically
            columnWidget.add(
              DropdownButton(
                items: _options.map((String option) {
                  return DropdownMenuItem<String>(
                    child: new Text(option),
                    value: option,
                  );
                }).toList(),
                hint: Text('Please select answer'), //Text(answerModel.answer),
                value: 'Please select answer',
                onChanged: (String? newValue) {
                  setState(() {
                    print(newValue!);
                    //answerController.update(newValue);
                  });
                },
              ),
            );
            //Space between all questions
            columnWidget
                .add(Padding(padding: const EdgeInsets.only(top: 25.0)));
          }
          //End quiz aka section of quizzes button
          columnWidget.add(
            // Button to sumbit quiz placed outside the loop as it is only displayed at
            // the end of the page not after each and every question
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
              child: ElevatedButton(
                onPressed: () {
                  //quizController.answerQuizByLessonId(lessonId,listOfQuizzes.elementAt(i).id, _selectedAnswers);
                  List<bool> isQuizGraded = [
                    //TODO MOCKED
                    true,
                    false
                  ]; //2 quizzes here for SPECIFIC LESSON, frst one taken, second one not
                  MomentumRouter.goto(context, GradesQuizSpecificsPage,
                      params: GradesQuizSpecificsParam(
                          isQuizGraded, param!.lessonId, 0, 0));
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
    }

    // Add UI pazzazz to view
    Widget _getTabBarViewDecor() {
      Widget _tabBarViewDecor = Container(
          height: 400,
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
        controllers: [QuizController],
        builder: (context, snapshot) {
          // Get the list of quizzes so that I can dynamically edit UI
          final quizzes = snapshot<QuizPageModel>();
          quizController = Momentum.controller<QuizController>(context);
          lessonId = param!.lessonId;
          quizController.getQuizzes(lessonId);
          quizId = quizzes.quizes.elementAt(0).id;
          questionId = quizzes.quizes.first.id;
          noOfQuizzes = quizzes.quizes.length;
          listOfQuizzes = List.from(quizzes.quizes);

          //Get and store answers
          //answerModel = snapshot<AnswerPageModel>();
          //answerController = Momentum.controller<AnswerController>(context);
          return _getChild();
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
    final param = MomentumRouter.getParam<QuizParam>(context);
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
          lessonId = param!.lessonId;
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