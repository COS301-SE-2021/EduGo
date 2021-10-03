import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/CreateVirtualEntityWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

import 'SentenceInputCard.dart';
import 'WordInputCard.dart';

class QuestionCard extends StatefulWidget {
  final int questionId;
  final String question;
  final String questionType;

  final List<String> questionOptions;
  final GlobalKey<FormState> quizFormKey;

  QuestionCard(
      {Key key,
      this.questionId,
      this.question,
      this.questionOptions,
      this.questionType,
      this.quizFormKey})
      : super(
          key: key,
        );

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  int missingWordCount = 0;
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CreateVirtualEntityController, QuizBuilderController],
      builder: (context, snapshot) {
        var quizBuilder = snapshot<QuizBuilderModel>();

        return Material(
          elevation: 40,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: DropdownButton<String>(
                          value: (quizBuilder
                                      .questions[widget.questionId].type !=
                                  null)
                              ? '${quizBuilder.questions[widget.questionId].type}'
                              : "TrueFalse",
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 40,
                          underline: Container(
                            height: 2,
                            color: Color.fromARGB(255, 97, 211, 87),
                          ),
                          elevation: 20,
                          onChanged: (String type) {
                            Momentum.controller<QuizBuilderController>(context)
                                .inputQuestionType(type, widget.questionId);
                          },
                          items: <String>[
                            'TrueFalse',
                            'MultipleChoice',
                            'FillinMissingWord',
                            'ImageQuestion'
                          ].map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      Spacer(),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: Icon(Icons.delete,
                              size: 40,
                              color: Color.fromARGB(255, 97, 211, 87)),
                          onTap: () {
                            Momentum.controller<QuizBuilderController>(context)
                                .removeQuestion(widget.questionId);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                (quizBuilder.questions[widget.questionId].type ==
                        'FillinMissingWord')
                    ? Align(
                        child: DropdownButton<String>(
                          value: missingWordCount.toString() == "0"
                              ? null
                              : missingWordCount.toString(),
                          icon: const Icon(Icons.arrow_drop_down),
                          hint: Text("Number of missing words"),
                          iconSize: 40,
                          underline: Container(
                            height: 2,
                            color: Color.fromARGB(255, 97, 211, 87),
                          ),
                          elevation: 20,
                          onChanged: (String num) {
                            setState(() {
                              missingWordCount = int.parse(num);
                            });
                            Momentum.controller<QuizBuilderController>(context)
                                .setMissingWords(
                                    widget.questionId, missingWordCount);
                          },
                          items: <String>[
                            '2',
                            '3',
                            '4',
                            '5',
                          ].map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      )
                    : QuestionInputCard(
                        questionId: widget.questionId,
                      ),
                SizedBox(
                  height: 40,
                ),
                (quizBuilder.questions[widget.questionId].type ==
                        'FillinMissingWord')
                    ? Row(
                        children: [
                          Column(
                            children: [
                              SentenceInputCard(
                                questionId: widget.questionId,
                                width: 400,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Column(
                                children:
                                    Momentum.controller<QuizBuilderController>(
                                            context)
                                        .buildQuizBuilderSentenceView(
                                            widget.questionId),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              WordInputCard(
                                questionId: widget.questionId,
                                width: 400,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Column(
                                children:
                                    Momentum.controller<QuizBuilderController>(
                                            context)
                                        .buildQuizBuilderWordView(
                                            widget.questionId),
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox(),
                (quizBuilder.questions[widget.questionId].type ==
                            "MultipleChoice" ||
                        quizBuilder.questions[widget.questionId].type ==
                            "ImageQuestion")
                    ? QuestionOptionInputCard(questionId: widget.questionId)
                    : SizedBox(),
                SizedBox(
                  height: 40,
                ),
                (quizBuilder.questions[widget.questionId].type ==
                            "MultipleChoice" ||
                        quizBuilder.questions[widget.questionId].type ==
                            "ImageQuestion")
                    ? Momentum.controller<QuizBuilderController>(context)
                        .buildQuizBuilderOptionView(widget.questionId)
                    : SizedBox(),
                SizedBox(
                  height: 40,
                ),
                (quizBuilder.questions[widget.questionId].type ==
                        'FillinMissingWord')
                    ? Text(Momentum.controller<QuizBuilderController>(context)
                        .getSentence(widget.questionId))
                    : Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 32.0, bottom: 40),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: DropdownButton<String>(
                                hint: Text(
                                  "Choose correct answer",
                                  style: TextStyle(fontSize: 20),
                                ),
                                value:
                                    '${quizBuilder.questions[widget.questionId].correctAnswer}',
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 40,
                                underline: Container(
                                  height: 2,
                                  color: Color.fromARGB(255, 97, 211, 87),
                                ),
                                elevation: 20,
                                onChanged: (String answer) {
                                  Momentum.controller<QuizBuilderController>(
                                          context)
                                      .inputCorrectAnswer(
                                          answer, widget.questionId);
                                },
                                items: quizBuilder
                                    .questions[widget.questionId].options
                                    .map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: SizedBox(
                                        width: ScreenUtil().setWidth(300),
                                        child: Text(
                                          value,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                          Spacer(),
                          (quizBuilder.questions[widget.questionId].type ==
                                  'ImageQuestion')
                              ? (quizBuilder.questions[widget.questionId]
                                      .imageLink.isEmpty)
                                  ? VirtualEntityButton(
                                      elevation: 40,
                                      child: Text(
                                        "Upload Question Image",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Momentum.controller<
                                                QuizBuilderController>(context)
                                            .uploadQuestionImage(
                                                context, widget.questionId);
                                      },
                                      width: 400,
                                      height: 60)
                                  : Column(
                                      children: [
                                        VirtualEntityButton(
                                            elevation: 40,
                                            child: Text(
                                              "Discard Image",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Momentum.controller<
                                                          QuizBuilderController>(
                                                      context)
                                                  .discardQuestionImage(
                                                      widget.questionId);
                                            },
                                            width: 200,
                                            height: 60),
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 20.0,
                                            ),
                                            child: Image.network(
                                              quizBuilder
                                                  .questions[widget.questionId]
                                                  .imageLink,
                                              width: 500,
                                              height: 200,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                              : SizedBox(),
                        ],
                      ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
