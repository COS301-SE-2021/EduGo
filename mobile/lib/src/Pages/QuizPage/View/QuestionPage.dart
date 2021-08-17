import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuestionPageController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuestionPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
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
  @override
  Widget build(BuildContext context) {
    // questions stored in param variable as it was passed as a parameter
    // from another page to this one.
    final param = MomentumRouter.getParam<QuestionParam>(context);

    // Additional text and button widgets are added to the children's array,
    // which builds thhe UI.
    var child = Column(
      children: [],
    );

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
              // Update question
              final questionController =
                  Momentum.controller<QuestionPageController>(context);
              questionController.updateQuestionDetails(param!.questions);

              // Question Model snapshot of details
              final question = snapshot<QuestionPageModel>();

              // Question to be asked
              Widget questionTextWidget = Text(question.questionText);
              child.children.add(questionTextWidget);

              // Optional answers to select from
              String? _value = '';
              List<Widget> _optionsTextWidgets = List<Widget>.generate(
                  question.optionsText!.length, (int index) {
                String optionText = question.optionsText!.elementAt(index);
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
                child.children.add(_optionsTextWidget);
              }

              // Next button
              Widget nextButton = ElevatedButton(
                onPressed: (_isEnabled)
                    ? () => Momentum.controller<QuestionPageController>(context)
                            .updateQuestionDetails(param.questions)
                        ? {
                            //ANSWER DETAILS
                            _isEnabled = true,
                            MomentumRouter.goto(context, QuestionPage,
                                params: QuestionParam(param.questions)),
                          }
                        : {
                            _isEnabled = false,
                          }
                    : null,
                child: const Text('Next Question'),
              );
              child.children.add(nextButton);

              return Center(
                child: child,
              );
              /*print(questions.quizes.first.questions!.first.question);
              var allQuestions =
                  questions.quizes.map((e) => e.questions!.map((e) ,
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
        'Question');
  }
}
