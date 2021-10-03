import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizzesPageController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizzesPageModel.dart';
import 'package:momentum/momentum.dart';

class QuizPageView extends StatefulWidget {
  const QuizPageView({Key? key}) : super(key: key);

  @override
  _QuizPageViewState createState() => _QuizPageViewState();
}

class _QuizPageViewState extends State<QuizPageView> {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [QuizzesPageController],
        builder: (context, snapshot) {
          var quiz = snapshot<QuizzesPageModel>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 97, 211, 87),
              title: Row(
                children: [
                  Icon(Icons.menu, color: Colors.white),
                  Spacer(),
                  Text(
                    'Quiz ' + quiz.currentQuiz.getId().toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            body: quiz.currentQuestion,
          );
        });
  }
}
