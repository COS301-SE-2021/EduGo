import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuestionPageController.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/View/QuestionPage.dart';
import 'package:momentum/momentum.dart';

// 12:40 base quiz
// 13:00 TODO get quiz by lesson id 3
// 13:30 TODO: Edit display (hardcode)
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
  late int noOfQuestions = 0; //TODO get no of questions via controller

  @override
  void initState() {
    super.initState();
    noOfQuizzes = 0;
    noOfQuestions = 0;
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

    //View of questions
    TabBarView _buildTabBarView(int noOfQuestions) {
      TabBarView _tabBarView = TabBarView(children: <Widget>[]);
      for (int i = 0; i < noOfQuizzes; i++) {
        // i=0 because questions are in a list
        _tabBarView.children.add(
          Container(
            child: Center(
              //TODO display all questions here
              child: Text('all questions',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
          child: _buildTabBarView(noOfQuestions));
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
          final quizzes = snapshot<QuizPageModel>();
          final quizController = Momentum.controller<QuizController>(context);
          final int lessonId = 3; //TODO pass in id dynamically lessonId
          quizController.getQuizzes(lessonId);
          noOfQuizzes = quizzes.quizes.length;
          return _getChild();
        });
    //Display page
    return MobilePageLayout(false, false, _momentumBuilder, 'Quizzes');
  }
}
/* RESPONSE
{
    "data": [
        {
            "id": 7,
            "questions": [
                {
                    "id": 9,
                    "type": "TrueFalse",
                    "question": "What is the answer",
                    "correctAnswer": "True",
                    "options": [
                        "True",
                        "False"
                    ]
                },
                {
                    "id": 10,
                    "type": "MultipleChoice",
                    "question": "What is the second answer",
                    "correctAnswer": "B",
                    "options": [
                        "A",
                        "B",
                        "C",
                        "D"
                    ]
                },
                {
                    "id": 11,
                    "type": "MultipleChoice",
                    "question": "What is the third answer",
                    "correctAnswer": "Maybe",
                    "options": [
                        "Yes",
                        "No",
                        "Maybe",
                        "Wait"
                    ]
                }
            ]
        },
        {
            "id": 8,
            "questions": [
                {
                    "id": 12,
                    "type": "TrueFalse",
                    "question": "What is the answer",
                    "correctAnswer": "True",
                    "options": [
                        "True",
                        "False"
                    ]
                },
                {
                    "id": 13,
                    "type": "MultipleChoice",
                    "question": "What is the second answer",
                    "correctAnswer": "B",
                    "options": [
                        "A",
                        "B",
                        "C",
                        "D"
                    ]
                },
                {
                    "id": 14,
                    "type": "MultipleChoice",
                    "question": "What is the third answer",
                    "correctAnswer": "Maybe",
                    "options": [
                        "Yes",
                        "No",
                        "Maybe",
                        "Wait"
                    ]
                }
            ]
        }
    ]
}
 */
