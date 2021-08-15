import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntity/View/Widgets/QuestionInputCard.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntity/View/Widgets/QuestionOptionInputCard.dart';

class QuestionCard extends StatelessWidget {
  final int questionId;
  final String question;
  final String questionType;
  final List<String> questionOptions;

  const QuestionCard(
      {Key key,
      this.questionId,
      this.question,
      this.questionOptions,
      this.questionType})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [VirtualEntityApiController, QuizBuilderController],
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
                          value:
                              (quizBuilder.questions[questionId].type != null)
                                  ? '${quizBuilder.questions[questionId].type}'
                                  : "True or False",
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 40,
                          underline: Container(
                            height: 2,
                            color: Color.fromARGB(255, 97, 211, 87),
                          ),
                          elevation: 20,
                          onChanged: (String type) {
                            Momentum.controller<QuizBuilderController>(context)
                                .inputQuestionType(type, questionId);
                          },
                          items: <String>['True or False', 'Multiple Choice']
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
                                .removeQuestion(questionId);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                QuestionInputCard(questionId: questionId),
                SizedBox(
                  height: 40,
                ),
                (quizBuilder.questions[questionId].type == "Multiple Choice")
                    ? QuestionOptionInputCard(questionId: questionId)
                    : SizedBox(),
                SizedBox(
                  height: 40,
                ),
                (quizBuilder.questions[questionId].type == "Multiple Choice")
                    ? Momentum.controller<QuizBuilderController>(context)
                        .buildQuizBuilderOptionView(questionId)
                    : SizedBox(),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, bottom: 10.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Correct Answer",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: DropdownButton<String>(
                      value: (quizBuilder.questions[questionId].correctAnswer !=
                              null)
                          ? '${quizBuilder.questions[questionId].correctAnswer}'
                          : (quizBuilder
                                  .questions[questionId].options.isNotEmpty)
                              ? '${quizBuilder.questions[questionId].options.elementAt(0)}'
                              : null,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 40,
                      underline: Container(
                        height: 2,
                        color: Color.fromARGB(255, 97, 211, 87),
                      ),
                      elevation: 20,
                      onChanged: (String answer) {
                        Momentum.controller<QuizBuilderController>(context)
                            .inputCorrectAnswer(answer, questionId);
                      },
                      items: quizBuilder.questions[questionId].options
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