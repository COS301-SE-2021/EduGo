import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuestionController.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuestionModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Controller/VirtualEntityController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:http/http.dart' as http;
import 'package:momentum/momentum.dart';

class QuizView extends StatefulWidget {
  QuizView({Key? key}) : super(key: key);

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? _value = '';
    bool isSelected = false;

    Widget displayQuestions(QuestionModel questions) {
      return Column(
        children:
            List<Widget>.generate(questions.optionsText.length, (int index) {
          String currrentOption = questions.optionsText.elementAt(index);
          if (questions.type == QuestionType.TrueFalse) {
            return ChoiceChip(
              label: Text(currrentOption),
              selected: _value == currrentOption,
              onSelected: (bool selected) {
                setState(() {
                  _value = selected ? currrentOption : null;
                });
              },
            );
          } else
            return FilterChip(
                label: Text(currrentOption),
                labelStyle: TextStyle(color: Colors.white),
                backgroundColor: Colors.green,
                selected: isSelected,
                onSelected: (bool value) {
                  setState(() {
                    isSelected = value;
                  });
                });
        }).toList(),
      );
    }

    //Display page
    return MobilePageLayout(
        false,
        false,
        MomentumBuilder(
            controllers: [QuizController],
            builder: (context, snapshot) {
              final quizzes = snapshot<QuizModel>();
              final quizController =
                  Momentum.controller<QuizController>(context);
              //TODO call update functio in controller

              final questions = snapshot<QuestionModel>();
              final questionController =
                  Momentum.controller<QuestionController>(context);

              // If optional answers for the quiz have been added, display question
              if (questions.optionsText.isNotEmpty) {
                return displayQuestions(questions);
              }
              return Row(children: [Text('no questions to display')]);
            }),
        'Quiz');
  }
}
//TODO get virtual entity
