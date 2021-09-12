/**
 * This is the grade quiz specific page. This page shows the 
 * specific information of the quiz such as the students mark,
 * the quiz mark, the quiz title and the quiz' correct answers 
 * and the student's answers. 
*/

import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';

/*------------------------------------------------------------------------------
 *                   Grade Quiz Specific View Page 
 *------------------------------------------------------------------------------
*/

//TODO: FIX UP DESIGN OF THIS PAGE. CHECK IF YOU WILL RECEIVE
//A LIST OF ANSWERS(STUDENT AND CORRECT) AND SEE IF YOU NEED THE
//ID AND QUIZ TITLE

class GradesQuizSpecificsPage extends StatefulWidget {
  //Holds the quiz title
  // final String quizTitle;

  //Holds the quizid
  // final int id;

  //Holds the mark that the
  //student received for the quiz
  final int studentQuizMark;

  //Holds the total mark
  //that the quiz was out of
  final int quizTotalMark;

  // // Holds the list of the correct answers
  // final List<String> correctAnswers;

  // // Holds the list of the student answers
  // final List<String> studentAnswers;

  //LessonPage constructor
  GradesQuizSpecificsPage({
    Key? key,
    required this.studentQuizMark,
    required this.quizTotalMark,
  }) : super(key: key);
  // static String id = "lessons";

  @override
  _GradesQuizSpecificsPageState createState() => _GradesQuizSpecificsPageState(
        quizTotalMark: this.quizTotalMark,
        studentQuizMark: this.studentQuizMark,
      );
}

class _GradesQuizSpecificsPageState extends State<GradesQuizSpecificsPage> {
  //Holds the quiz title
  // final String quizTitle;

  //Holds the quizid
  // final int id;

  //Holds the mark that the student received for the quiz
  final int studentQuizMark;

  //Holds the total mark that the quiz was out of
  final int quizTotalMark;

  //Holds the list of student answers to be
  //passed in from the GradesQuizCard
  // final List<String> studentAnswers;

  // //Holds the list of quizzes to be
  // //passed in from the GradesQuizCard
  // final List<String> correctAnswers;

  _GradesQuizSpecificsPageState({
    required this.quizTotalMark,
    required this.studentQuizMark,
  });

  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
      //mobilepagelayout takes 3 arguments. 2 bools and a momentumbuilder.
      //the two bool represent side bar and navbar. so if true and true, them
      //the side bar and nav bar will be displayed.
      //i.e true=yes display, false=no do not display
      false,
      false,
      Container(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text(
                  'Your Mark:',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.black,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  '$studentQuizMark',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  'Quiz total mark:',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.black,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  '$quizTotalMark',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            //TODO: DISPLAY QUIZ ANSWERS. THE STUDENT'S ANSWERS AS WELL
            //AS THE CORRECT ANSWERS
          ],
        ),
      ),
      'Grades Quiz Specific Page',
    );
  }
}
