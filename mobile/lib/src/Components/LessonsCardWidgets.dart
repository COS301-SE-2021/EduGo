/**
   * This widget will be a stateless widget and is responsible for displaying the 
   * lesson as cards. There will be a title, id and description that can be passed 
   * into the constructor when displaying the lesson cards.
*/
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/LessonsPage/View/LessonInformationPage.dart';

/*------------------------------------------------------------------------------
 *                  Lesson Card used in the lesson page 
 *------------------------------------------------------------------------------
*/

//TODO: ADD IN LESSON COMPLETED/NOT COMPLETED BASED ON QUIZ STATUS(HAS QUIZ
//BEEN TAKEN IN LESSON. YES OR NO). SEE IF YOU NEED THE LESSON COMPLETED VARIABLE.
//SIMK CAN ADD A BOOL IN THE DATA RETURNED FROM ENDPOINT WHEREBY HE CAN QUECK IF
//QUIZZES HAVE BEEN ANSWERED..I.E HAVE A MARK..IF YES, MAKE BOOL TRUE, ELSE FALSE

class LessonsCard extends StatelessWidget {
  //Holds the lesson title
  final String lessonTitle;

  //Holds the lessonid
  final int lessonID;

  //Holds the lesson description
  final String lessonDescription;

  //indicated if all quizzes have been completed and
  //have a grade. Thus the lesson is completed
  final String lessonCompleted;

//LessonCardConstructor. Takes in 4 arguments
  LessonsCard(
      {required this.lessonTitle,
      required this.lessonID,
      required this.lessonDescription,
      required this.lessonCompleted});

  @override
  Widget build(BuildContext context) {
    //Holds the background colour for the container if it
    //is completed or not. Green=completed. Red=not completed.
    //A lesson is comoleted if all the quizes have been answered
    //for that lesson
    Color backgroundColour;

    //Holds the lesson status. Completed or not completed
    String lessonStatus;

    if (lessonCompleted == "true") {
      lessonStatus = 'Completed';
      backgroundColour = Color.fromRGBO(34, 139, 34, 1);
    } else {
      lessonStatus = 'Not Completed';
      backgroundColour = Color.fromRGBO(178, 34, 34, 1);
    }

    //This is the main lesson card design. It is all in a container and
    //displays info like the lesson title, lesson objectives and
    //the lesson
    // return Card(
    //   semanticContainer: true,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   clipBehavior: Clip.antiAlias,
    //   color: Colors.black,
    //   //This allows the card to be clickable so that when clicked,
    //   // it will go to the lessons description for that lesson
    //   child: new InkWell(
    //     //This redirects the page to the lessons description page on tap
    //     //and passes in the lesson description, lesson objectives and lesson title
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => LessonInformationPage(
    //             lessonTitle: this.lessonTitle,
    //             lessonDescription: this.lessonDescription,
    //             lessonID: this.lessonID,
    //           ),
    //         ),
    //       );
    //     },
    //     child: Container(
    //       child: Column(
    //         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           Expanded(
    //             //   child: Container(
    //             //     color: backgroundColour,
    //             //     child: Align(
    //             //       alignment: Alignment.center,
    //             child: Padding(
    //               padding: const EdgeInsets.only(top: 30),
    //               child: Text(
    //                 "$lessonTitle",
    //                 textAlign: TextAlign.center,
    //                 overflow: TextOverflow.ellipsis,
    //                 maxLines: 3,
    //                 softWrap: true,
    //                 style: TextStyle(
    //                     fontSize: 30,
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.white),
    //                 // ),
    //                 //),
    //               ),
    //             ),
    //           ),
    //           Expanded(
    //             //   child: Container(
    //             //     color: backgroundColour,
    //             //     alignment: Alignment.center,
    //             child: Padding(
    //               padding: const EdgeInsets.only(top: 10),
    //               child: Text(
    //                 "$lessonStatus",
    //                 textAlign: TextAlign.center,
    //                 overflow: TextOverflow.ellipsis,
    //                 maxLines: 3,
    //                 softWrap: true,
    //                 style: TextStyle(
    //                     fontSize: 17,
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.white),
    //               ),
    //               //),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Card(
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        color: Colors.black,
        //This allows the card to be clickable so that when clicked,
        // it will go to the lessons description for that lesson
        child: new InkWell(
          //This redirects the page to the lessons description page on tap
          //and passes in the lesson description, lesson objectives and lesson title
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LessonInformationPage(
                  lessonTitle: this.lessonTitle,
                  lessonDescription: this.lessonDescription,
                  lessonID: this.lessonID,
                ),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  color: backgroundColour,
                  child: Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "$lessonTitle",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   child: Container(
              //     color: backgroundColour,
              //     alignment: Alignment.center,
              //     child: Text(
              //       "$lessonStatus",
              //       textAlign: TextAlign.center,
              //       overflow: TextOverflow.ellipsis,
              //       maxLines: 3,
              //       softWrap: true,
              //       style: TextStyle(
              //           fontSize: 17,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white),
              //     ),
              //   ),
              // )
            ],
          ),
        ));
  }
}
