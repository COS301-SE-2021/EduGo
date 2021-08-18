import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:momentum/momentum.dart';
import 'package:flutter/material.dart';

class QuizResultParam extends RouterParam {
  final List<String?> selectedAnswers;
  final List<String?> correctAnswers;

  QuizResultParam(this.correctAnswers, this.selectedAnswers);
}

class QuizResultView extends StatefulWidget {
  QuizResultView({
    Key? key,
  }) : super(key: key);

  @override
  _QuizResultViewState createState() => _QuizResultViewState();
}

class _QuizResultViewState extends State<QuizResultView> {
  int finalMark = 0;
  int _calcFinalMark(
      List<String?> selectedAnswers, List<String?> correctAnswers) {
    for (int index = 0; index < correctAnswers.length; index++) {
      if (selectedAnswers.elementAt(index) == correctAnswers.elementAt(index)) {
        finalMark++;
      }
    }
    return finalMark;
  }

  @override
  Widget build(BuildContext context) {
    // Object param is used to pass answers between pages
    final param = MomentumRouter.getParam<QuizResultParam>(context);

    //Store answers from student's list of answers
    //and display as a comma sepatated string string
    String concatSelAns = param!.selectedAnswers.join(', ');
    //Store answers from correct list of answers
    //and display as a comma sepatated string string
    String concatCorAns = param.correctAnswers.join(', ');
    return MobilePageLayout(
      true,
      true,
      Container(
        //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        //child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Your Mark:',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.black,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _calcFinalMark(param.selectedAnswers, param.correctAnswers)
                      .toString(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Quiz total mark:',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.black,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  param.correctAnswers.length.toString(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.width / 10,
                child: Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () {},
                    minWidth: 10,
                    height: 60,
                    child: Text(
                      "Your answers: " + concatSelAns,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.width / 10,
                child: Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => DetectMarkerPage()),
                      // );
                    },
                    minWidth: 10,
                    height: 60,
                    child: Text(
                      "Correct answers: " + concatCorAns,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      'Quiz Result',
    );
  }
}
