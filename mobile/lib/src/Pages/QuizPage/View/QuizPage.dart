import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizPageModel.dart';
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
    // This function takes the data of the question retrieved via the getQuizByLesson API call
    // and places it in widgets to be displayed via the UI
    Widget _getQuestionWidget(Question question, BuildContext context) {
      // Widget to be returned and displayed
      var columnWidget = Column(
        children: [],
      );

      // Text of the actual question. e.g. What is 1+1?
      columnWidget.children.add(
        Text(
          question.question,
          //style: Theme.of(context).textTheme.headline4,
        ),
      );

      // Optional answers the student may select: https://material.io/components/chips/flutter#using-chips
      String? _value = '';
      List<Widget> _optionsTextWidgets =
          List<Widget>.generate(question.options!.length, (int index) {
        String optionText = question.options!.elementAt(index);
        if (question.type == QuestionType.TrueFalse) {
          return ChoiceChip(
            label: Text(optionText),
            selected: _value == optionText,
            onSelected: (bool selected) {
              setState(() {
                _value = selected ? optionText : null;
              });
            },
          );
        } else //if(question.type == QuestionType.MultipleChoice)
          return FilterChip(
              label: Text(optionText),
              labelStyle: TextStyle(color: Colors.white),
              backgroundColor: Colors.green,
              selected: _value == optionText,
              onSelected: (bool selected) {
                setState(() {
                  _value = selected ? optionText : null;
                });
              });
      }).toList();

      for (var _optionsTextWidget in _optionsTextWidgets) {
        columnWidget.children.add(_optionsTextWidget);
      }
      return columnWidget;
    }

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
              List<Question> questions = [];
              //print('ek is hier'); makes it in then throws error
              var allQuestions =
                  quizzes.quizes.map((e) => e.questions!.map((e) {
                        questions.add(e);
                        print(e.toString());
                      }));
              if (index <= allQuestions.length) {
                index++;
                return Row(children: [
                  //Text(questions.elementAt(index).question)
                ]); //return Row(children: [Text(index.toString())]);
              }
              return Row(children: [Text('no quiz to display')]);
            }),
        'Quiz');
  }
}
//TODO get virtual entity
