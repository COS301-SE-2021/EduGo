import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/src/Components/QuizCardWidget.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *                           Quiz View Page
 *------------------------------------------------------------------------------
*/

class QuizPage extends StatefulWidget {
  //Store the lesson id that is passed in
  //from LessonSpecific page
  final int lessonID;

  //QuizPage constructor
  QuizPage({Key? key, required this.lessonID}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState(lessonID: lessonID);
}

class _QuizPageState extends State<QuizPage> {
  final int lessonID;
  _QuizPageState({required this.lessonID});

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [QuizController],
      builder: (context, snapshot) {
        //Stores a snapshot of the current quizes
        //list in the QuizModel page
        final quizzes = snapshot<QuizModel>();
        final quizController = Momentum.controller<QuizController>(context);
        //Call the quiz function call every time quiz page is reloaded
        //to update the number of quizzes
        quizController.getQuizzes(lessonID);

        int numberOfQuizzes = quizzes.quizzes.length;

        // Create numbered tabs whereby each number represents a quiz
        // allowing the student to toggle between quizzes
        List<Tab> tabs = <Tab>[];
        for (int i = 0; i < numberOfQuizzes; i++) {
          tabs.add(
            Tab(
              text: (i + 1).toString(),
            ),
          );
        }
        if (quizzes.quizzes.isNotEmpty && quizzes.quizzes.length > 0) {
          return Container(
            //Used for tabs
            child: DefaultTabController(
              length: numberOfQuizzes,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Quizzes"),
                  bottom: TabBar(
                    tabs: tabs,
                  ),
                ),
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: quizzes.quizzes
                      .map(
                          (question) => QuizCard(questions: question.questions))
                      .toList(),
                ),
              ),
            ),

            //),
          );
        } else
          return SpinKitCircle(
            color: Colors.black,
          );
      },
    );
  }
}
