import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizPageController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizPageModel.dart';
import 'package:momentum/momentum.dart';

class QuizView extends StatefulWidget {
  QuizView({Key? key}) : super(key: key);

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  //Next question button
  bool _isEnabled = true;

  //Widget
  Widget _getQuestionWidget(QuestionModel question, BuildContext context) {
    /*Align(
      //Align the side bar
      alignment: Alignment.centerRight,
      heightFactor: 1.00,
      widthFactor: 1.00,
      child: Drawer(
        child: ListQuizView(
          padding: EdgeInsets.zero,
          children: <Widget>[ */
    //Widget to be returned
    var columnWidget = Column(
      children: [],
    );

    //Text of the actual question. e.g. What is 1+1?
    columnWidget.children.add(
      Text(
        '${question.questionText}',
        //style: Theme.of(context).textTheme.headline4,
      ),
    );

    String? _selectedAnswer;
    bool isValidAnswer = false;
    for (String _optionsText in question.optionsText) {
      Widget _optionsTextWidget = RadioListTile<String>(
          title: Text(_optionsText),
          value: _optionsText,
          groupValue: _selectedAnswer,
          toggleable: false,
          onChanged: (String? val) {
            setState(() {
              _selectedAnswer = val;
              if (_selectedAnswer != null) {
                print('not null');
                if (_selectedAnswer == question.correctAnswer) {
                  print('true');
                  isValidAnswer = true;
                } else {
                  isValidAnswer = false;
                  print('false');
                }
              }
            });
          });
      columnWidget.children.add(_optionsTextWidget);
    }
    //Next qustion button
    //TODO talk to Sim K about mark alloc
    int mark = 1;
    List<int> markPerQuestion = [];
    int finalMark = 0;

    Widget nextButton = ElevatedButton(
      onPressed: (_isEnabled)
          ? () => Momentum.controller<QuestionController>(context)
                  .isNextQuestionRetrievable(questions)
              ? {
                  _isEnabled = true,
                  if (isValidAnswer == true)
                    {
                      print(_selectedAnswer),
                      markPerQuestion.add(mark),
                      finalMark++,
                    }
                } //all but last question
              : {
                  _isEnabled = false,
                } //last question
          : null,
      child: const Text('Next Question'),
    );
    columnWidget.children.add(nextButton);

    //End quiz button
    Widget endQuizBtn = ElevatedButton(
      onPressed: () {
        MomentumRouter.goto(context, QuizResultPage,
            params: QuizResultParam(finalMark, markPerQuestion));
      },
      child: const Text('End Quiz'),
    );
    columnWidget.children.add(endQuizBtn);
    return columnWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Momentum Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MomentumBuilder(
              controllers: [QuestionController],
              builder: (context, snapshot) {
                var question = snapshot<QuestionModel>();
                return _getQuestionWidget(question, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
