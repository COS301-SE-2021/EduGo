/**
 * This is the grade quiz page. This page shows the quizzes of
 * a particular lesson with the individual quiz marks that the student 
 * achieved. When clicked, it will take the student to the 
 * GradeQuizSpecifics page. The GradeQuiz card widget is used 
 * to display the GradeQuiz cards.  
*/

import 'package:flutter/material.dart';
import 'package:mobile/src/Components/ErrorHandelingCard.dart';
import 'package:mobile/src/Components/GradesQuizCardWidget.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';

/*------------------------------------------------------------------------------
 *                         Grade Quiz View Page 
 *------------------------------------------------------------------------------
*/

class GradesQuizPage extends StatefulWidget {
  //Holds the list of quizzes to be
  //passed in from the GradesQuizCard
  final List<Quiz> quizList;

  //Holds the list of student answers to be
  //passed in from the GradesQuizCard
  // final List<String> studentAnswers;

  // //Holds the list of quizzes to be
  // //passed in from the GradesQuizCard
  // final List<String> correctAnswers;

  GradesQuizPage({
    Key? key,
    required this.quizList,
  }) : super(key: key);

  @override
  _GradesQuizState createState() => _GradesQuizState(
        quizList: this.quizList,
      );
}

class _GradesQuizState extends State<GradesQuizPage> {
  final List<Quiz> quizList;

  _GradesQuizState({
    required this.quizList,
  });

  //TODO:
  //CHANGE THIS PAGE TO DISPLAY CARDS OF THE QUIZ SECTION RATHER THAN INDIVIDUAL QUIZZES
  //A LESSON NO LONGER HAS MORE THAN ONE QUIZ. IT HAS ONE BIG QUIZ WITH
  //DIFFERENT SECTIONS INSTEAD
  @override
  Widget build(BuildContext context) {
    if (quizList.isNotEmpty && quizList.length > 0) {
      return MobilePageLayout(
        false,
        false,
        Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      'Quiz Marks',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                GridView.count(
                  //This makes 2 cards appear. So effectively
                  //two cards per page. (2 rows, 1 card per row)
                  childAspectRatio: MediaQuery.of(context).size.height / 300,
                  primary: false,
                  padding: const EdgeInsets.only(top: 20),
                  crossAxisSpacing: 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  mainAxisSpacing: 10,
                  //makes 1 cards per row
                  crossAxisCount: 1,
                  //Call subject card here and pass in all arguments required
                  children: quizList
                      .map(
                        (quiz) =>
                            //Pass in the entire lesson list of quizzes
                            //Also pass in the lesson title and the overall lesson mark
                            //as a percentage
                            GradesQuizCard(
                          //quizTitle: quiz.title,
                          studentQuizMark: quiz.student_score,
                          quizTotalMark: quiz.quiz_total,
                          //id: quiz.id,
                          //studentAnswers: quiz.studentAnswers,
                          //correctAnswers: quiz.correctAnswers,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      '');
    } else
      return MobilePageLayout(
        false,
        false,
        ErrorCard(
          errorDescription:
              "There is currently no mark for this quiz to be displayed",
        ),
        ''
      );
  }
}
