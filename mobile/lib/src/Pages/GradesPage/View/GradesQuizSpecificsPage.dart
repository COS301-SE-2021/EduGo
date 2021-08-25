/**
 * This is the grade quiz specific page. This page shows the 
 * specific information of the quiz such as the students mark,
 * the quiz mark, the quiz title and the quiz' correct answers 
 * and the student's answers. 
*/

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *                   Grade Quiz Specific View Page 
 *------------------------------------------------------------------------------
*/
class GradesQuizSpecificsParam extends RouterParam {
  final LinkedHashMap<int, int>
      studentQuizMark; //mark scored ... (map quizId with what student scored)
  final LinkedHashMap<int, int>
      quizTotalMark; // out of total for... (map quizId with total score)
  final LinkedHashMap<int, bool>
      isQuizGraded; // all the quizzes (int is quizId, bool is whether or not quz completed)...
  final int lessonId; // ...for a specific lesson

  //e.g. There's a lesson with an Id of 1 that has 3 quizzes.
  // thee first 2 were completed and graded. the last one wasn't
  // mapping the quizId and a bool can be used to determine which quizzes were answered for that lesson
  //
  GradesQuizSpecificsParam(this.isQuizGraded, this.lessonId,
      this.studentQuizMark, this.quizTotalMark);
}

class GradesQuizSpecificsPage extends StatefulWidget {
  //LessonPage constructor
  GradesQuizSpecificsPage({
    Key? key,
  }) : super(key: key);
  // static String id = "lessons";

  @override
  _GradesQuizSpecificsPageState createState() =>
      _GradesQuizSpecificsPageState();
}

class _GradesQuizSpecificsPageState extends State<GradesQuizSpecificsPage> {
  @override
  Widget build(BuildContext context) {
    //TODO access which quizzes were complete to display grades for only quizzes taken
    final param = MomentumRouter.getParam<GradesQuizSpecificsParam>(context);
    print('For this specific lessonId: ' + param!.lessonId.toString());
    for (var isGraded in param.isQuizGraded.values) {
      if (isGraded) {
        print('Quiz is graded, display grades');
      } else {
        print('Quiz is NOT graded, DO NOT display grades');
      }
    }
    //Store answers from student's list of answers
    //and display as a comma sepatated string string
    // String array = studentAnswers.join(', ');
    // //Store answers from correct list of answers
    // //and display as a comma sepatated string string
    // String array2 = correctAnswers.join(', ');
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
            // Align(
            //   alignment: Alignment.center,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 25),
            //     child: Text(
            //       quizTitle,
            //       overflow: TextOverflow.ellipsis,
            //       maxLines: 2,
            //       softWrap: false,
            //       style: TextStyle(
            //           fontSize: 30,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black),
            //     ),
            //   ),
            // ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text(
                  'Your Mark for:',
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
                  param.studentQuizMark[0]
                      .toString(), //mark that the student scored on the first quiz, iterate it however you'd like
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
                  param.quizTotalMark[0]
                      .toString(), //total of the first quiz, iterate it however you'd like
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
            // Padding(
            //   padding: const EdgeInsets.only(top: 70),
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width / 1,
            //     height: MediaQuery.of(context).size.width / 10,
            //     child: Align(
            //       alignment: Alignment.center,
            //       child: MaterialButton(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(20)),
            //           side: BorderSide(color: Colors.black),
            //         ),
            //         onPressed: () {
            //           // Navigator.push(
            //           //   context,
            //           //   MaterialPageRoute(
            //           //       builder: (context) => DetectMarkerPage()),
            //           // );
            //         },
            //         minWidth: 10,
            //         height: 60,
            //         child: Text(
            //           "Your answers: " + array,
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 40),
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width / 1,
            //     height: MediaQuery.of(context).size.width / 10,
            //     child: Align(
            //       alignment: Alignment.center,
            //       child: MaterialButton(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(20)),
            //           side: BorderSide(color: Colors.black),
            //         ),
            //         onPressed: () {
            //           // Navigator.push(
            //           //   context,
            //           //   MaterialPageRoute(
            //           //       builder: (context) => DetectMarkerPage()),
            //           // );
            //         },
            //         minWidth: 10,
            //         height: 60,
            //         child: Text(
            //           "Correct answers: " + array2,
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      'Grades Quiz Specific Page',
    );
  }
}
