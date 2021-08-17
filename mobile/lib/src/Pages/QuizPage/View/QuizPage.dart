import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/View/QuestionPage.dart';
import 'package:momentum/momentum.dart';

class QuizPage extends StatefulWidget {
  //final int lessonId;
  QuizPage({
    Key? key,
    /*required this.lessonId*/
  }) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState(/*lessonId: this.lessonId*/);
}

class _QuizPageState extends State<QuizPage> {
  //final int lessonId;
  _QuizPageState();
  //_QuizPageState({required this.lessonId});
  @override
  void initState() {
    super.initState();
    int index = -1;
  }

  int index = -1;
  @override
  Widget build(BuildContext context) {
    //Display page
    return MobilePageLayout(
        false,
        false,
        MomentumBuilder(
            // Quiz controller fetches JSON data of the Quiz
            // Question controller displays a question at a time while maintaining state (has index and list if questions)
            controllers: [QuizController],
            builder: (context, snapshot) {
              //List of quizes
              final quizzes = snapshot<QuizPageModel>();
              final quizController =
                  Momentum.controller<QuizController>(context);
              //TODO pass in id dynamically lessonId
              quizController.getQuizzes(1);
              return Container(
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    MomentumRouter.goto(context, QuestionPage,
                        params: QuestionParam(
                            //TODO pass in id dynamically lessonId instead of 1
                            quizzes.quizes.elementAt(0).questions));
                  },
                  child: const Text('Start Quiz'),
                ),
              );
              /*print(quizzes.quizes.first.questions!.first.question);
              var allQuestions =
                  quizzes.quizes.map((e) => e.questions!.map((e) {
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
        'Quiz');
  }
}
//TODO get virtual entity
