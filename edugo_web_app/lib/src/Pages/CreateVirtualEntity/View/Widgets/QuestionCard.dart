import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/CreateVirtualEntityWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class QuestionCard extends StatefulWidget {
  final int questionId;
  final String question;
  final String questionType;
  final List<String> questionOptions;
  final GlobalKey<FormState> quizFormKey;

  const QuestionCard(
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
                          items: <String>['TrueFalse', 'MultipleChoice']
                              .map<DropdownMenuItem<String>>(
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
                QuestionInputCard(
                  questionId: widget.questionId,
                ),
                SizedBox(
                  height: 40,
                ),
                (quizBuilder.questions[widget.questionId].type ==
                        "MultipleChoice")
                    ? QuestionOptionInputCard(questionId: widget.questionId)
                    : SizedBox(),
                SizedBox(
                  height: 40,
                ),
                (quizBuilder.questions[widget.questionId].type ==
                        "MultipleChoice")
                    ? Momentum.controller<QuizBuilderController>(context)
                        .buildQuizBuilderOptionView(widget.questionId)
                    : SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0, bottom: 40),
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
                        Momentum.controller<QuizBuilderController>(context)
                            .inputCorrectAnswer(answer, widget.questionId);
                      },
                      items: quizBuilder.questions[widget.questionId].options
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
              ],
            ),
          ),
        );
      },
    );
  }
}
