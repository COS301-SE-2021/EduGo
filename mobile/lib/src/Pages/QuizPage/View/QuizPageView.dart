import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

//TODO UI: https://www.geeksforgeeks.org/basic-quiz-app-in-flutter-api/
class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    Widget child = Container(child: Text("Quiz"));

    return MobilePageLayout(
      true,
      true,
      child,
    );
  }
}
