import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuestionController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuestionModel.dart';
import 'package:momentum/momentum.dart';

class QuizView extends StatefulWidget {
  QuizView({Key? key}) : super(key: key);

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  @override
  Widget build(BuildContext context) {
    return MobilePageLayout(
        false,
        false,
        //Container(
        MomentumBuilder(
            controllers: [QuestionController],
            builder: (context, snapshot) {
              // Get the list of questions of
              final questions = snapshot<QuestionModel>();

              // Call update function in controller
              final questionController =
                  Momentum.controller<QuestionController>(context);

              return Row();
            }),
        'Quiz');
  }
}
//TODO get virtual entity
