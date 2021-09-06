/**
   * This widget will be a stateless widget and is responsible for displaying the
   * Quizzes as cards. There will be a question and a questionType that
   * can be passed into the constructor when displaying the Quiz cards.
*/
import 'package:flutter/material.dart';
import 'package:mobile/Constants.dart';
import 'package:mobile/src/Components/AnswerButtons.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/AnswerController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/AnswerModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/Quiz.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *                    Question Card used in the Quiz page
 *------------------------------------------------------------------------------
 */

class QuestionCard extends StatefulWidget {
  //Holds the question id
  final int id;

  //Holds the actual question
  final String question;

  //Holds the answer options
  final List<String> answerOptions;

  //Holds the question type. Either multiple
  //choice or true of false type
  final QuestionType questionType;

  final int questionLength;

  final int index;

//This is the subject card constructor. it requires 5 arguments to be passed in
  QuestionCard(
      {required this.id,
      required this.question,
      required this.answerOptions,
      required this.questionType,
      required this.questionLength,
      required this.index});

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool hasBeenPressed1 = false;
  // List<bool> checkArray = [];

  // void setArray(int index) {
  //   checkArray[index] = true;
  // }

  bool value = false;
  @override
  Widget build(BuildContext context) {
    // for (int i = 0; i < 10; i++) {
    //   checkArray.add(false);
    // }

    List<String> answersForQuestion = [];

    for (int i = 0; i < widget.answerOptions.length; i++) {
      answersForQuestion.add(widget.answerOptions[i]);
    }

    print("-------------------");
    print("The answers in the answerForQuestions list are: " +
        answersForQuestion.asMap().toString());

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text.rich(
            TextSpan(
              text: "Question ${widget.index + 1}",
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: kSecondaryColor),
              children: [
                TextSpan(
                  text: "/${widget.questionLength}",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: kSecondaryColor),
                ),
              ],
            ),
          ),
          //),
          Divider(thickness: 1.5),
          Container(
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Text(
                  '${widget.question}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: kBlackColor),
                ),
                (QuestionType.TrueFalse == widget.questionType)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GridView.count(
                            //This makes 2 cards appear. So effectively two cards
                            //per page. (2 rows, 1 card per row)
                            childAspectRatio:
                                MediaQuery.of(context).size.height / 100,
                            primary: false,
                            // padding: const EdgeInsets.all(20),
                            //crossAxisSpacing: 20,
                            shrinkWrap: true,
                            //makes 1 cards per row
                            crossAxisCount: 1,
                            children: List.generate(
                              answersForQuestion.length,
                              (index) => AnswerButtons(
                                answer: answersForQuestion[index],
                                index: index,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 5,
                              height: MediaQuery.of(context).size.height / 14,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                    side: BorderSide(color: Colors.green)),
                                onPressed: () {},
                                minWidth: 5,
                                height: 25,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Submit question",
                                      maxLines: 2,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GridView.count(
                            //This makes 2 cards appear. So effectively two cards
                            //per page. (2 rows, 1 card per row)
                            childAspectRatio:
                                MediaQuery.of(context).size.height / 50,
                            primary: false,
                            crossAxisSpacing: 20,
                            shrinkWrap: true,
                            //makes 1 cards per row
                            crossAxisCount: 1,
                            children: List.generate(
                              answersForQuestion.length,
                              (index) => AnswerButtons(
                                answer: answersForQuestion[index],
                                index: index,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 5,
                              height: MediaQuery.of(context).size.height / 14,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                    side: BorderSide(color: Colors.green)),
                                onPressed: () {},
                                minWidth: 5,
                                height: 25,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Submit question",
                                      maxLines: 2,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
    //  },
    // );
  }
}
