/**
   * This widget will be a stateless widget and is responsible for displaying the
   * Quizzes as cards. There will be a question and a questionType that
   * can be passed into the constructor when displaying the Quiz cards.
*/
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mobile/Constants.dart';
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

  final int questionLength;

//This is the subject card constructor. it requires 5 arguments to be passed in
  QuestionCard(
      {required this.id,
      required this.question,
      required this.answerOptions,
      required this.questionType,
      required this.questionLength});

  @override
  Widget build(BuildContext context) {
    List<String> answersForQuestion = [];

    for (int i = 0; i < answerOptions.length; i++)
      answersForQuestion.add(answerOptions[i]);

    print("-------------------");
    print("The answers in the answerForQuestions list are: " +
        answersForQuestion.asMap().toString());

    return Container(
      //children: [
      //  child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      //         //child: ProgressBar(),
      //       ),
      //       SizedBox(height: kDefaultPadding),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      //         // child: Obx(
      //         child: Text.rich(
      //           TextSpan(
      //             text: "Question 1",
      //             style: Theme.of(context)
      //                 .textTheme
      //                 .headline4!
      //                 .copyWith(color: kSecondaryColor),
      //             children: [
      //               TextSpan(
      //                 text: "/${questionLength}}",
      //                 style: Theme.of(context)
      //                     .textTheme
      //                     .headline5!
      //                     .copyWith(color: kSecondaryColor),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),

      //       Divider(thickness: 1.5),
      //       SizedBox(height: kDefaultPadding),
      //       // Expanded(
      //       //   child: PageView.builder(
      //       //     // Block swipe to next qn
      //       //     physics: NeverScrollableScrollPhysics(),
      //       //     controller: _questionController.pageController,
      //       //     onPageChanged: _questionController.updateTheQnNum,
      //       //     itemCount: _questionController.questions.length,
      //       //     itemBuilder: (context, index) => QuestionCard(
      //       //         question: _questionController.questions[index]),
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // semanticContainer: true,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(20),
      // ),
      // clipBehavior: Clip.antiAlias,
      // child: Container(
      //   decoration: BoxDecoration(
      //     border: Border.all(
      //       color: Colors.purple,
      //       width: 0.5,
      //     ),
      //   ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            //child: ProgressBar(),
          ),
          SizedBox(height: kDefaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            // child: Obx(
            child: Text.rich(
              TextSpan(
                text: "Question 1",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: kSecondaryColor),
                children: [
                  TextSpan(
                    text: "/${questionLength}}",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: kSecondaryColor),
                  ),
                ],
              ),
            ),
          ),

          Divider(thickness: 1.5),
          // child: Column(
          //   children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              // width: MediaQuery.of(context).size.width / 2,
              // height: MediaQuery.of(context).size.height / 2,
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     color: Colors.purple,
              //     width: 0.5,
              //   ),
              // ),
              // alignment: Alignment.center,
              // child: Container(
              //   decoration: BoxDecoration(
              //     color: Colors.orange,
              //     borderRadius: BorderRadius.circular(25),
              //   ),
              //   width: MediaQuery.of(context).size.width / 2,
              //   height: MediaQuery.of(context).size.height / 4,
              //   child: Padding(
              //     padding:
              //         const EdgeInsets.only(top: 30, left: 10, right: 10),
              //     child: Text(
              //       //If there is a mark, display it.
              //       //Else display the two dashes
              //       '$question',
              //       textAlign: TextAlign.center,
              //       overflow: TextOverflow.ellipsis,
              //       maxLines: 4,
              //       softWrap: true,
              //       style: TextStyle(
              //           fontSize: 25,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.black),
              //     ),
              //   ),
              // ),margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Text(
                    '$question',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: kBlackColor),
                  ),
                  (QuestionType.TrueFalse == questionType)
                      ? //Padding(
                      //padding: const EdgeInsets.only(top: 30),
                      GridView.count(
                          //This makes 2 cards appear. So effectively two cards
                          //per page. (2 rows, 1 card per row)
                          childAspectRatio:
                              MediaQuery.of(context).size.height / 100,
                          primary: false,
                          padding: const EdgeInsets.all(20),
                          crossAxisSpacing: 30,
                          //mainAxisSpacing: 10,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          //mainAxisSpacing: 10,
                          //makes 1 cards per row
                          crossAxisCount: 1,
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
                                MediaQuery.of(context).size.height / 100,
                            primary: false,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 30,
                            shrinkWrap: true,
                            // mainAxisSpacing: 10,
                            //makes 1 cards per row
                            crossAxisCount: 1,
                            children: answersForQuestion
                                .map((e) => AnswerButtons(answer: e))
                                .toList(),
                          ),
                        )
                ],
              ),
            ),
          ),
        ],
      ),
      //],
    );
    //);
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quiz_app/controllers/question_controller.dart';
// import 'package:mobile/models/Questions.dart';
// import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
// import '../../../constants.dart';
// import 'option.dart';

// class QuestionCard extends StatelessWidget {
//   const QuestionCard({
//     Key key,
//     // it means we have to pass this
//     @required this.question,
//   }) : super(key: key);

//   final Question question;

//   @override
//   Widget build(BuildContext context) {
//     QuestionController _controller = Get.put(QuestionController());
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//       padding: EdgeInsets.all(kDefaultPadding),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Column(
//         children: [
//           Text(
//             question.question,
//             style: Theme.of(context)
//                 .textTheme
//                 .headline6
//                 .copyWith(color: kBlackColor),
//           ),
//           SizedBox(height: kDefaultPadding / 2),
//           ...List.generate(
//             question.options.length,
//             (index) => Option(
//               index: index,
//               text: question.options[index],
//               press: () => _controller.checkAns(question, index),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
