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
  @override
  void initState() {
    super.initState();
    //int index = -1;
  }
  //int index = -1;

  // Number of quizzes = number of tabs
  int noOfQuizzes = 2; //TODO get no of quizzes via controller
  // Number of questions = number of tab views
  int noOfQuestions = 3; //TODO get no of questions via controller

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
    Widget tabBarDecor = Container(
      child: TabBar(
        labelColor: Colors.green,
        unselectedLabelColor: Colors.black,
        tabs: _buildTabs(noOfQuizzes),
      ),
    );

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
    Widget _tabBarDecor = Container(
        height:
            400, //height of TabBarView //TODO might have to use frationally sized box
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
        child: _buildTabBarView(noOfQuestions));

    // Structure of tabs
    DefaultTabController _defaultTabController = DefaultTabController(
        length: noOfQuizzes,
        initialIndex: 0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[tabBarDecor, _tabBarDecor]));

    // The contents of the screen
    Widget child = Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20.0),
            _defaultTabController,
          ]),
    );

    //Display page
    return MobilePageLayout(false, false, child, 'Quizzes');
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
