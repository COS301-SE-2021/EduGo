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

// 12:40 base quiz
// 13:00 get quiz by lesson id 3
// 13:30 Edit display (hardcode)
// 13:30 TODO: get and display questions
// 14:00 TODO: Modify to be dynamict
//15:00 TODO: link with Kieran
class QuizPage extends StatefulWidget {
  //final int lessonId;
  QuizPage({
    Key? key,
    /*required this.lessonId*/
  }) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState(/*lessonId: this.lessonId*/);
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
  late List<String?> _selectedAnswers;
  late List<String?> _correctAnswers;
  @override
  void initState() {
    super.initState();
    listOfQuizzes = [];
    noOfQuizzes = 0;
    noOfQuestions = 0;
    _selectedAnswers = [];
    _correctAnswers = [];
  }
  //int index = -1;

  @override
  Widget build(BuildContext context) {
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

    // Button to sumbit quiz placed outside the loop as it is only displayed at
    // the end of the page not after each and every question
    Widget endQuizBtn() {
      return Padding(
        padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
        child: ElevatedButton(
          onPressed: (null),
          child: const Text('End Quiz'),
        ),
      );
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
                    });
                  },
                ));
              } else if (questions.elementAt(q).type ==
                  QuestionType.MultipleChoice) {
                columnWidget.add(FilterChip(
                    label: Text(optionalAnswer),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: Colors.grey,
                    selected: _value == optionalAnswer,
                    selectedColor: Colors.green,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? optionalAnswer : 'N/A';
                      });
                    }));
              }
            }
            //Space between all questions
            columnWidget
                .add(Padding(padding: const EdgeInsets.only(top: 25.0)));
          }

          columnWidget.add(endQuizBtn());
          return columnWidget;
        }

        // Adding all the contents we gathered in a neat display by calling the function
        _tabBarView.children.add(
          Container(
            child: Scrollbar(
              isAlwaysShown: true, //TODO wants a controller ugh
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
          final quizzes = snapshot<QuizPageModel>();
          final quizController = Momentum.controller<QuizController>(context);
          final int lessonId = 3; //TODO pass in id dynamically lessonId
          quizController.getQuizzes(lessonId);
          noOfQuizzes = quizzes.quizes.length;
          listOfQuizzes = List.from(quizzes.quizes);

          return _getChild();
        });
    //Display page
    return MobilePageLayout(false, false, _momentumBuilder, 'Quizzes');
  }
}
