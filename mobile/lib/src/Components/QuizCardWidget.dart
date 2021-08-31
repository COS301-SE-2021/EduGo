/**
   * This widget will be a stateless widget and is responsible for displaying the 
   * Quizzes as cards. There will be a question and a questionType that 
   * can be passed into the constructor when displaying the Quiz cards.
*/
import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/QuizPage/Model/Quiz.dart';

/*------------------------------------------------------------------------------
 *                    Quiz Card used in the Quiz page 
 *------------------------------------------------------------------------------
 */

class QuizCard extends StatelessWidget {
  //Holds the questions for a quiz
  // final List<Question> questions;

  //Holds the question id
  final int id;

  //Holds the actual question
  final String question;

  //Holds the answer options
  final List<String> answerOptions;

//This is the subject card constructor. it requires 5 arguments to be passed in
  QuizCard({
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    //This is the main subject card design. It is all in a container and
    //displays info like the subject photo, subject title, subject educator
    //and how many lessons are in that subject
    return Card(
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      //color: Color.fromARGB(255, 97, 211, 87),
      color: Colors.black,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.purple,
            width: 0.5,
          ),
        ),
        Text(questions.map((e) => e.question))
      ),
    );
  }
}
