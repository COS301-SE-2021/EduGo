/**
   * This widget will be a stateless widget and is responsible for 
   * displaying the quiz questions/answers cards for the GradesSubject page. 
   * There will be a question title, student's answer andf the correct answer
**/

import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/GradesPage/Model/Grades.dart';

/*------------------------------------------------------------------------------
 *              QuiAnswers Cards used in the GradeQuiz page 
 *------------------------------------------------------------------------------
*/

class QuizAnswerCard extends StatelessWidget {
  //Holds the question id
  final int id;

  //Holds the correct answer
  final String correctAnswer;

  //Holds the student answer
  final String studentAnswer;

  //Holds the question
  final String question;

  //Constructor
  QuizAnswerCard(
      {required this.id,
      required this.studentAnswer,
      required this.correctAnswer,
      required this.question});

  @override
  Widget build(BuildContext context) {
    //This is the main subject card design. It is all in a container and
    //displays info like the subject photo, subject title, subject educator
    //and how many lessons are in that subject

    Color forStudent;
    Color forCorrectAnswer;

    if (correctAnswer == studentAnswer) {
      forStudent = Colors.green;
      forCorrectAnswer = Colors.green;
    } else {
      forStudent = Colors.red;
      forCorrectAnswer = Colors.green;
    }

    return Card(
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.green, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      color: Colors.black,
      //This allows the card to be clickable so that when clicked,
      // it will go to the lessons for that subject
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Flexible(
                  child: Text(
                    '$question',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Flexible(
                  child: Text(
                    "Your answer was: ",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Flexible(
                  child: Text(
                    '$studentAnswer',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: forStudent,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Flexible(
                  child: Text(
                    "The correct answer was: ",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Flexible(
                  child: Text(
                    '$correctAnswer',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: forCorrectAnswer),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
