import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:mobile/src/Pages/QuizPage/Model/Data/Question.dart';
import 'package:momentum/momentum.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizzesPageModel.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizzesPageController.dart';

class QuestionCard extends StatefulWidget {
  // final int questionId;
  // final String question;
  // final List<String> answerOptions;
  final Question question;
  QuestionCard({
    Key? key,
    // required this.questionId,
    required this.question,
    // required this.answerOptions
  }) : super(key: key);

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    //print('TYPE: ' + widget.question.getType());
    return MomentumBuilder(
      controllers: [QuizzesPageController],
      builder: (context, snapshot) {
        var quiz = snapshot<QuizzesPageModel>();
        //Fill in the missing word question content
        if (widget.question.getType() == 'ImageQuestion') {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 0),
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
                  Expanded(
                    child: Center(
                      child: Text(
                        "Question " + (quiz.questionCount + 1).toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color.fromARGB(255, 97, 211, 87),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 100.00,
                      height: 100.00,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: NetworkImage(widget.question.getImage()),
                          //image: ExactAssetImage(widget.question.getImage()), //mock
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 0),
                      child: Text(
                        widget.question.getQuestion(),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 40, //70,
                        right: 40, //70,
                      ),
                      child: RadioGroup<String>.builder(
                        activeColor: Color.fromARGB(255, 97, 211, 87),
                        direction: Axis.vertical,
                        groupValue: quiz.currentAnswer,
                        onChanged: (value) {
                          Momentum.controller<QuizzesPageController>(context)
                              .chooseAnswer(value!);
                        },
                        items: widget.question.getAnswerOptions(),
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Momentum.controller<QuizzesPageController>(context)
                          .answerQuestion(context);
                    },
                    child: Expanded(
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
                              horizontal: 40.0, //90.0,
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
                  ),
                ],
              ),
            ),
          );
        }
        //Fill in the missing word question content
        if (widget.question.getType() == 'FillinMissingWord') {
          // create column of optional dropdowns with accompanying text. The number of
          // column are the number of blanks that need to be filled.
          List<Widget> column = [];

          RegExp regExp = new RegExp(
            r"_____",
            caseSensitive: false,
            multiLine: false,
          );
          print("no of blanks: " +
              regExp
                  .allMatches(widget.question.getQuestion())
                  .length
                  .toString());
          for (var i = 0;
              i < regExp.allMatches(widget.question.getQuestion()).length;
              i++) {
            column.add(
              DropDown(
                items: widget.question.getAnswerOptions(),
                hint: Text(
                    'Blank no.' + (i + 1).toString()), //(quiz.currentAnswer),
                icon: Icon(
                  Icons.expand_more,
                  color: Colors.green,
                ),
                onChanged: (String? value) {
                  Momentum.controller<QuizzesPageController>(context)
                      .chooseAnswers(value!, i);
                },
              ),
            );
          }
          //display question content.
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
                  // question asked
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      widget.question.getQuestion(),
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
                      left: 40, //70,
                      right: 40, //70,
                    ),
                    child: Center(
                      child: Column(children: column),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //answer questions
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
                            horizontal: 40, //90.0,
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
        }

        //Default
        //if ((widget.question.getType() == QuestionType.TrueFalse) || (widget.question.getType() == QuestionType.MultipleChoice))
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
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
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.question.getQuestion(),
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
                    left: 20, //70,
                    right: 20, //70,
                  ),
                  child: RadioGroup<String>.builder(
                    activeColor: Color.fromARGB(255, 97, 211, 87),
                    direction: Axis.vertical,
                    groupValue: quiz.currentAnswer,
                    onChanged: (value) {
                      Momentum.controller<QuizzesPageController>(context)
                          .chooseAnswer(value!);
                    },
                    items: widget.question.getAnswerOptions(),
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
                      left: 20.0,
                      right: 20.0,
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
