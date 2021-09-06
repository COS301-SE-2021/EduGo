// /**
//    * This widget will be a stateless widget and is responsible for displaying the
//    * Quizzes as cards. There will be a question and a questionType that
//    * can be passed into the constructor when displaying the Quiz cards.
// */
import 'package:flutter/material.dart';
import 'package:mobile/src/Components/QuestionCardWidget.dart';
import 'package:mobile/src/Pages/QuizPage/Model/Quiz.dart';

/*------------------------------------------------------------------------------
 *                    Quiz Card used in the Quiz page 
 *------------------------------------------------------------------------------
 */

class QuizCard extends StatelessWidget {
  //Holds the questions
  final List<Question> questions;

//This is the subject card constructor. it requires 5 arguments to be passed in
  QuizCard({required this.questions});

  @override
  Widget build(BuildContext context) {
    int questionLength = questions.length;
    return GridView.count(
      //This makes 2 cards appear. So effectively two
      //cards per page. (2 rows, 1 card per row)
      childAspectRatio: MediaQuery.of(context).size.height / 500,
      primary: false,
      //padding: const EdgeInsets.only(top: 20),
      crossAxisSpacing: 0,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      // mainAxisSpacing: 5,
      //makes 1 cards per row
      crossAxisCount: 1,
      children: questions
          .map(
            (question) => QuestionCard(
                id: question.id,
                question: question.question,
                answerOptions: question.options,
                questionType: question.type,
                questionLength: questionLength),
          )
          .toList(),
    );
    //));
  }
}
