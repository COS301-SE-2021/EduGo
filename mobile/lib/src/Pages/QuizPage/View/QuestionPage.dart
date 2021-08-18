//Hourly
//7am, fix question display uisn momenutm
//8am, fix button click
//TODO 11:30am, FIX ARRAY selected answers (when click button) and correct answers array
//10 am answer page get actual mark
//TODO 11am answer quiz api call
//TODO 12pm remove quiz from sidebar, make password visible onlcik
import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuestionPageController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuestionPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:mobile/src/Pages/QuizPage/View/QuizResultView.dart';
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
  late List<String> _filters;
  late String? _value;
  late List<String?> _selectedAnswers;
  late List<String?> _correctAnswers;
  @override
  void initState() {
    super.initState();
    _value = '';
    _selectedAnswers = [];
    _correctAnswers = [];
  }

  @override
  Widget build(BuildContext context) {
    // questions stored in param variable as it was passed as a parameter
    // from another page to this one.
    final param = MomentumRouter.getParam<QuestionParam>(context);
    // Toggle enable or disable for next button
    bool _isEnabled = true;

    // Display Page
    return MobilePageLayout(
        false,
        false,
        MomentumBuilder(
            // Quiz controller fetches JSON data of the Quiz
            // Question controller displays a question at a time while maintaining state (has index and list if questions)
            controllers: [QuestionPageController],
            builder: (context, snapshot) {
              // Question Model snapshot of details
              final question = snapshot<QuestionPageModel>();

              // Additional text and button widgets are added to the children's array,
              // which builds thhe UI.
              var child = Column(
                children: [],
              );

              // Question to be asked
              Widget questionTextWidget = Text(question.questionText);
              child.children.add(questionTextWidget);

              // Optional answers to select from. These answers will be stored in the list
              // ONLY when the next question button is clicke.
              List<Widget> _optionsTextWidgets = List<Widget>.generate(
                  question.optionsText!.length, (int index) {
                String optionText = question.optionsText!.elementAt(index);
                //TODO FIX SET STATE selected chip animation (fix color change once widget selected)
                if (question.type == QuestionType.TrueFalse) {
                  //_value == optionText ? print('yes') : print('no');
                  return ChoiceChip(
                    selectedColor: Colors.green,
                    backgroundColor: Colors.grey,
                    label: Text(optionText),
                    //labelStyle: TextStyle(color: Colors.white),
                    selected: _value == optionText,
                    onSelected: (bool selected) {
                      //print(selected.toString());
                      setState(() {
                        _value = selected ? optionText : '';
                        _isEnabled = true;
                        //print(_value);
                      });
                    },
                  );
                }
                if (question.type == QuestionType.MultipleChoice) {
                  return FilterChip(
                      label: Text(optionText),
                      labelStyle: TextStyle(color: Colors.white),
                      backgroundColor: Colors.grey,
                      selected: _value == optionText,
                      selectedColor: Colors.green,
                      onSelected: (bool selected) {
                        setState(() {
                          _isEnabled = true;
                          _value = selected ? optionText : null;
                        });
                      });
                }
                return Text('no optional answers');
              }).toList();

              for (var _optionsTextWidget in _optionsTextWidgets) {
                child.children.add(_optionsTextWidget);
              }

              // Next button
              Widget nextButton = ElevatedButton(
                onPressed: (_isEnabled)
                    ? () => Momentum.controller<QuestionPageController>(context)
                            .updateQuestionDetails(param!.questions)
                        ? {
                            //ANSWER DETAILS
                            _isEnabled = true,
                            //print('true'),
                            _selectedAnswers.add(_value),
                            _correctAnswers.add(question.correctAnswer),
                            //print(_value), print(question.correctAnswer),
                          }
                        : {
                            _isEnabled = false,
                            //print('false'),
                            _selectedAnswers.add(_value),
                            _correctAnswers.add(question.correctAnswer),
                            //print(_value), print(question.correctAnswer),
                          }
                    : null,
                child: const Text('Next Question'),
              );
              child.children.add(nextButton);

              //End quiz button
              //TODO redirect to Lesson specifics page
              Widget endQuizBtn = ElevatedButton(
                onPressed: () {
                  _selectedAnswers.add(_value);
                  _correctAnswers.add(question.correctAnswer);

                  MomentumRouter.goto(context, QuizResultView,
                      params:
                          QuizResultParam(_selectedAnswers, _correctAnswers));
                },
                child: const Text('End Quiz'),
              );
              child.children.add(endQuizBtn);

              return Center(
                child: child,
              );
            }),
        'Question');
  }
}
