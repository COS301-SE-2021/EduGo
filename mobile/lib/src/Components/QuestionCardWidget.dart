/**
   * This widget will be a stateless widget and is responsible for displaying the 
   * Quizzes as cards. There will be a question and a questionType that 
   * can be passed into the constructor when displaying the Quiz cards.
*/
import 'package:flutter/material.dart';
import 'package:mobile/src/Components/AnswerButtons.dart';
import 'package:mobile/src/Pages/QuizPage/Model/Quiz.dart';

/*------------------------------------------------------------------------------
 *                    Question Card used in the Quiz page 
 *------------------------------------------------------------------------------
 */

class QuestionCard extends StatelessWidget {
  //Holds the question id
  final int id;

  //Holds the actual question
  final String question;

  //Holds the answer options
  final List<String> answerOptions;

  //Holds the question type. Either multiple
  //choice or true of false type
  final QuestionType questionType;

//This is the subject card constructor. it requires 5 arguments to be passed in
  QuestionCard(
      {required this.id,
      required this.question,
      required this.answerOptions,
      required this.questionType});

  @override
  Widget build(BuildContext context) {
    List<String> answersForQuestion = [];

    for (int i = 0; i < answerOptions.length; i++)
      answersForQuestion.add(answerOptions[i]);

    print("-------------------");
    print("The answers in the answerForQuestions list are: " +
        answersForQuestion.asMap().toString());

    return Card(
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.purple,
            width: 0.5,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.purple,
                    width: 0.5,
                  ),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 4,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: Text(
                      //If there is a mark, display it.
                      //Else display the two dashes
                      '$question',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            (QuestionType.TrueFalse == questionType)
                ? //Padding(
                //padding: const EdgeInsets.only(top: 30),
                GridView.count(
                    //This makes 2 cards appear. So effectively two cards
                    //per page. (2 rows, 1 card per row)
                    childAspectRatio: MediaQuery.of(context).size.height / 200,
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 30,
                    shrinkWrap: true,
                    //mainAxisSpacing: 10,
                    //makes 1 cards per row
                    crossAxisCount: answersForQuestion.length,
                    children: answersForQuestion
                        .map((e) => AnswerButtons(answer: e))
                        .toList(),
                    //),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GridView.count(
                      //This makes 2 cards appear. So effectively two cards
                      //per page. (2 rows, 1 card per row)
                      childAspectRatio:
                          MediaQuery.of(context).size.height / 200,
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 30,
                      shrinkWrap: true,
                      // mainAxisSpacing: 10,
                      //makes 1 cards per row
                      crossAxisCount: answersForQuestion.length,
                      children: answersForQuestion
                          .map((e) => AnswerButtons(answer: e))
                          .toList(),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
