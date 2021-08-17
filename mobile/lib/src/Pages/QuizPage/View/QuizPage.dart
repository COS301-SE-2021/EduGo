import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
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
    int index = -1;
  }

  int index = -1;
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
            // Quiz controller fetches JSON data of the Quiz
            // Question controller displays a question at a time while maintaining state (has index and list if questions)
            controllers: [QuizController],
            builder: (context, snapshot) {
              //List of quizes
              final quizzes = snapshot<QuizPageModel>();
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
