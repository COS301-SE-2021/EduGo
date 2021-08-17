import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuestionPageController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuestionPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:momentum/momentum.dart';

// This class is used to pass a list of questions as a paramter when you click on the 'Start Quiz' button on the Quiz
// Page which navigates to this page.
class QuestionParam extends RouterParam {
  final List<Question>? questions;
  QuestionParam(this.questions);
}

//
class QuestionPage extends StatefulWidget {
  QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    final param = MomentumRouter.getParam<QuestionParam>(context);
    return MobilePageLayout(
        false,
        false,
        MomentumBuilder(
            // Quiz controller fetches JSON data of the Quiz
            // Question controller displays a question at a time while maintaining state (has index and list if questions)
            controllers: [QuestionPageController],
            builder: (context, snapshot) {
              //List of quizes
              final questions = snapshot<QuestionPageModel>();
              final questionController =
                  Momentum.controller<QuestionPageController>(context);
              //TODO pass in id dynamically lessonId
              if (questionController.getQuestionDetails(param!.questions)) {
                print('true');
              } else {
                print('false');
              }
              return Container(
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: null,
                  child: const Text('Start Question'),
                ),
              );
              /*print(questions.quizes.first.questions!.first.question);
              var allQuestions =
                  questions.quizes.map((e) => e.questions!.map((e) {
                        questions.add(e);
                        print("ek is hier");
                        print(questions.elementAt(0).question);
                      }));
              if (index <= allQuestions.length) {
                index++;
                return Row(children: [
                  //Text(questions.elementAt(index).question)
                ]); //return Row(children: [Text(index.toString())]);
              }*/
            }),
        'Question');
  }
}
