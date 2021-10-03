/**
 * This is the grade quiz specific page. This page shows the 
 * specific information of the quiz such as the students mark,
 * the quiz mark, the quiz title and the quiz' correct answers 
 * and the student's answers. 
*/

import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Model/GradesQuizSpecificsParam.dart';
import 'package:mobile/src/Components/QuizAnswersCard.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *                   Grade Quiz Specific View Page 
 *------------------------------------------------------------------------------
*/

class GradesQuizSpecificsPage extends StatefulWidget {
  //LessonPage constructor
  GradesQuizSpecificsPage({
    Key? key,
  }) : super(key: key);

  @override
  _GradesQuizSpecificsPageState createState() =>
      _GradesQuizSpecificsPageState();
}

class _GradesQuizSpecificsPageState extends State<GradesQuizSpecificsPage> {
  @override
  Widget build(BuildContext context) {
    List<QuizAnswers> quizAnswers = MomentumRouter.getParam<GradesQuizSpecificsParam>(context)?.quizAnswers ?? [];

    return MobilePageLayout(
        false,
        false,
        false,
        Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GridView.count(
                  //This makes 2 cards appear. So effectively
                  //two cards per page. (2 rows, 1 card per row)
                  childAspectRatio: MediaQuery.of(context).size.height / 400,
                  primary: false,
                  padding: const EdgeInsets.only(top: 20),
                  crossAxisSpacing: 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  mainAxisSpacing: 10,
                  //makes 1 cards per row
                  crossAxisCount: 1,
                  //Call subject card here and pass in all arguments required
                  children: quizAnswers
                      .map(
                        (quiz) =>
                            //Pass in the entire lesson list of quizzes
                            //Also pass in the lesson title and the overall lesson mark
                            //as a percentage
                            QuizAnswerCard(
                                correctAnswer: quiz.correctAnswer,
                                studentAnswer: quiz.answer,
                                id: quiz.id,
                                question: quiz.question.question),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        'Correct Answers');
  }
}
