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

class QuestionView extends StatefulWidget {
  QuestionView({Key? key}) : super(key: key);

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? _value = '';
    bool isSelected = false;

    List<Widget> displayQuestions(QuestionModel questions) {
      return List<Widget>.generate(questions.optionsText.length, (int index) {
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
      }).toList();
    }

    bool _isEnabled = true;
    Widget nextButton = ElevatedButton(
      child: const Text('Next Question'),
      onPressed: () => print('next'),
      /* (_isEnabled)
          ? () => Momentum.controller<QuestionController>(context)
                  .isNextQuestionRetrievable(questions)
                  //TODO ask Kieran, becuase here I need to get the mock questions
              ? {
                  _isEnabled = true,
              : {
                  _isEnabled = false,
                } //last question
          : null,
    */
    );

    //End quiz button
    Widget endQuizBtn = ElevatedButton(
      onPressed: () {
        print('go to quiz results');
        //TODO add quiz result page
        //MomentumRouter.goto(context, QuizResultPage,
        //params: QuizResultParam(finalMark, markPerQuestion));
      },
      child: const Text('End Quiz'),
    );

    //Display page
    return MobilePageLayout(
        false,
        false,
        MomentumBuilder(
            controllers: [QuestionController],
            builder: (context, snapshot) {
              final questions = snapshot<QuestionModel>();
              final questionController =
                  Momentum.controller<QuestionController>(context);

              // If optional answers for the quiz have been added, display question
              if (questions.optionsText.isNotEmpty) {
                var returnWidget = Column(
                  children: [],
                );
                // Display for question asked
                returnWidget.children.add(Text(questions.questionText));
                // List of optional answers
                for (var _question in displayQuestions(questions)) {
                  returnWidget.children.add(_question);
                }
                // Next question button
                returnWidget.children.add(nextButton);
                // End quiz button
                returnWidget.children.add(endQuizBtn);

                return returnWidget;
              }
              return Row(children: [Text('no options to display')]);
            }),
        'Question');
  }
}
//TODO get virtual entity
