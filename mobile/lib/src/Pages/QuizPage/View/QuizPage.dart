import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuestionPageController.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/View/QuestionPage.dart';
import 'package:momentum/momentum.dart';

// 12:40 TODO: base quiz
// 13:00 TODO get quiz by lesson id 3
// 13:30 Edit display (hardcode)
// 14:00 Modify to be dynamict
//15:00 link with Kieran
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

  // Number of quizzes = number
  int noOfQuizzes = 2; //TODO get no of quizzes via controller

  Widget child = Container(
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 20.0),
          DefaultTabController(
              length: 2, // TODO lenth of list of quizes
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: TabBar(
                        labelColor: Colors.green,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(text: '1'),
                          Tab(text: '2'),
                        ],
                      ),
                    ),
                    Container(
                        height: 400, //height of TabBarView
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: TabBarView(children: <Widget>[
                          Container(
                            child: Center(
                              child: Text('Start Quiz 1',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ]))
                  ])),
        ]),
  );
  @override
  Widget build(BuildContext context) {
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