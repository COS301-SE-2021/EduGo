/**
 * This is the grade quiz specific page. This page shows the 
 * specific information of the quiz such as the students mark,
 * the quiz mark, the quiz title and the quiz' correct answers 
 * and the student's answers. 
*/

import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/DetectMarkerPage/View/DetectMarkerPage.dart';

/*------------------------------------------------------------------------------
 *                   Grade Quiz Specific View Page 
 *------------------------------------------------------------------------------
*/

class GradesQuizSpecificsPage extends StatefulWidget {
  //Holds the quiz title
  final String quizTitle;

  //Holds the quizid
  final int id;

  //Holds the mark that the
  //student received for the quiz
  final int studentQuizMark;

  //Holds the total mark
  //that the quiz was out of
  final int quizTotalMark;

  //Holds the list of the correct answers
  //List<answers> correctAnswers;

  //Holds the list of the student answers
  //List<answers> studentAnswers;

  //LessonPage constructor
  GradesQuizSpecificsPage(
      {Key? key,
      required this.id,
      required this.studentQuizMark,
      required this.quizTitle,
      required this.quizTotalMark})
      : super(key: key);
  // static String id = "lessons";

  @override
  _GradesQuizSpecificsPageState createState() => _GradesQuizSpecificsPageState(
      id: this.id,
      quizTotalMark: this.quizTotalMark,
      quizTitle: this.quizTitle,
      studentQuizMark: this.studentQuizMark);
}

class _GradesQuizSpecificsPageState extends State<GradesQuizSpecificsPage> {
  //Holds the quiz title
  final String quizTitle;

  //Holds the quizid
  final int id;

  //Holds the mark that the student received for the quiz
  final int studentQuizMark;

  //Holds the total mark that the quiz was out of
  final int quizTotalMark;

  _GradesQuizSpecificsPageState(
      {required this.id,
      required this.quizTitle,
      required this.quizTotalMark,
      required this.studentQuizMark});

  @override
  Widget build(BuildContext context) {
    //Format the date objects by passing them from strings to date objects
    return MobilePageLayout(
      //mobilepagelayout takes 3 arguments. 2 bools and a momentumbuilder.
      //the two bool represent side bar and navbar. so if true and true, them
      //the side bar and nav bar will be displayed.
      //i.e true=yes display, false=no do not display
      false,
      false,
      Container(
        //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        //child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  quizTitle,
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
            // Align(
            //   alignment: Alignment.center,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 40),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Text(
            //           'Start time: ' +
            //               startDate.day.toString() +
            //               '-' +
            //               startDate.month.toString() +
            //               '-' +
            //               startDate.year.toString(),
            //           overflow: TextOverflow.ellipsis,
            //           maxLines: 2,
            //           softWrap: false,
            //           style: TextStyle(
            //               fontSize: 25,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black),
            //         ),
            //         Icon(
            //           Icons.alarm_outlined,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.center,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 25),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Text(
            //           'End time: ' +
            //               endDate.day.toString() +
            //               '-' +
            //               endDate.month.toString() +
            //               '-' +
            //               endDate.year.toString(),
            //           overflow: TextOverflow.ellipsis,
            //           maxLines: 2,
            //           softWrap: false,
            //           style: TextStyle(
            //               fontSize: 25,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black),
            //         ),
            //         Icon(
            //           Icons.alarm_outlined,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text(
                  'Lesson Description',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    //color: Colors.transparent,
                    decorationColor: Colors.black,
                    // shadows: [
                    //   Shadow(color: Colors.black, offset: Offset(0, -5))
                    // ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'lessonDescription',
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
                padding: const EdgeInsets.only(top: 80),
                child: Text(
                  'Lesson Outcomes',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    //color: Colors.transparent,
                    decorationColor: Colors.black,
                    // shadows: [
                    //   Shadow(color: Colors.black, offset: Offset(0, -5))
                    // ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  //lessonOutcomes,
                  'The outcome of this lesson is to ensure every student' +
                      'is comfortable with the basics of algebra',
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
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.width / 10,
                child: Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetectMarkerPage()),
                      );
                    },
                    //minWidth: MediaQuery.of(context).size.width / 180,
                    minWidth: 10,
                    height: 60,
                    child:
                        // Icon(
                        //   Icons.add_outlined,
                        //   color: Colors.white,
                        // ),
                        Text(
                      "Get Started",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
