import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizPageController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizPageModel.dart';
import 'package:momentum/momentum.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

//TODO UI: https://www.geeksforgeeks.org/basic-quiz-app-in-flutter-api/
class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    SingingCharacter? _character = SingingCharacter.lafayette;
    Widget _questionWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'This is where question go',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );

    String _answerText = "";
    Widget _answerWidget = ListTile(
      title: Text("jsjsj"),
      leading: Radio<SingingCharacter>(
        value: SingingCharacter.lafayette,
        groupValue: _character,
        onChanged: (SingingCharacter? value) {
          setState(() {
            _character = value;
          });
        },
      ),
    );
    Column _answersColumn = Column(
      children: [],
    );
    //for loop for amount of questions:
    _answersColumn.children.add(Text('Hello 123'));
    _answersColumn.children.add(Text('Hello 123'));
    _answersColumn.children.add(Text('Hello 123'));
    _answersColumn.children.add(Text('Hello 123'));

    Widget child = Stack(children: [_questionWidget, _answersColumn]);

    return MobilePageLayout(true, true, child);
    /*return MomentumBuilder(
        controllers: [QuizPageController],
        builder: (context, snapshot) {
          var QuizPage = snapshot<QuizPageModel>();
          return MobilePageLayout(
            true,
            true,
            child,
            //call function to update view: Momentum.controller<QuizPageController>(context).update(title, description, questions);
          );
        });*/
  }
}
