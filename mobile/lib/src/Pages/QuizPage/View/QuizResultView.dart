import 'package:momentum/momentum.dart';
import 'package:flutter/material.dart';

class QuizResultParam extends RouterParam {
  final int finalMark;
  final List<int> markPerQuestion;
  final List<String> givenAnswers;
  final List<String> correctAnswers;

  QuizResultParam(this.finalMark, this.markPerQuestion, this.givenAnswers,
      this.correctAnswers);
}

class QuizResultView extends StatefulWidget {
  QuizResultView({Key? key}) : super(key: key);

  @override
  _QuizResultViewState createState() => _QuizResultViewState();
}

class _QuizResultViewState extends State<QuizResultView> {
  @override
  Widget build(BuildContext context) {
    final param = MomentumRouter.getParam<QuizResultParam>(context);
    return Container(
      //TODO display mark per question, given answers and correct answers. Ask Kieran about string join thing
      child: Center(
          child: Text(
        'Final Mark: ' + '${param!.finalMark}',
        style: const TextStyle(fontSize: 20),
      )),
    );
  }
}
