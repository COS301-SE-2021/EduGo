import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizPageModel.dart';
import 'package:momentum/momentum.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //   String? _value = '';
    //   bool isSelected = false;

    //   Widget displayQuestions(QuestionModel questions) {
    //     return Column();
    //   }

    //Display page
    return MobilePageLayout(
        false,
        false,
        MomentumBuilder(
            controllers: [QuizController],
            builder: (context, snapshot) {
              //List of quizes
              final quizzes = snapshot<QuizPageModel>();
              var allQuestionText = quizzes.quizes
                  .map((e) => e.questions!.map((e) => print(e.question)));

              return Row(children: [Text('no questions to display')]);
            }),
        'Quiz');
  }
}
//TODO get virtual entity
