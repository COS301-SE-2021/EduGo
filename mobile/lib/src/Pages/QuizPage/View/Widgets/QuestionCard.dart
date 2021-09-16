import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:momentum/momentum.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizzesPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizzesPageController.dart';

class QuestionCard extends StatefulWidget {
  final int questionId;
  final String question;
  final List<String> answerOptions;
  QuestionCard(
      {Key? key,
      required this.questionId,
      required this.question,
      required this.answerOptions})
      : super(key: key);

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [QuizzesPageController],
      builder: (context, snapshot) {
        var quiz = snapshot<QuizzesPageModel>();

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          child: Material(
            shadowColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 40,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 60, bottom: 60),
              children: [
                Center(
                  child: Text(
                    "Question " + (quiz.questionCount + 1).toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color.fromARGB(255, 97, 211, 87),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    widget.question,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 70,
                    right: 70,
                  ),
                  child: RadioGroup<String>.builder(
                    activeColor: Color.fromARGB(255, 97, 211, 87),
                    direction: Axis.vertical,
                    groupValue: quiz.currentAnswer,
                    onChanged: (value) {
                      Momentum.controller<QuizzesPageController>(context)
                          .chooseAnswer(value!);
                    },
                    items: widget.answerOptions,
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Momentum.controller<QuizzesPageController>(context)
                        .answerQuestion(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 40.0,
                      left: 40.0,
                      right: 40.0,
                    ),
                    child: Material(
                      shadowColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 97, 211, 87),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 90.0,
                        ),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Next ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
