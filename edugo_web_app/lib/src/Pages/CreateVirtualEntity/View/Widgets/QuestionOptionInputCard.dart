import 'package:edugo_web_app/src/Pages/EduGo.dart';

class QuestionOptionInputCard extends StatefulWidget {
  final int questionId;
  final double width;
  final String hint;

  static var _controller = TextEditingController();

  QuestionOptionInputCard({
    Key key,
    this.questionId,
    this.width,
    this.hint,
  }) : super(key: key);

  @override
  _QuestionOptionInputCardState createState() =>
      _QuestionOptionInputCardState();
}

class _QuestionOptionInputCardState extends State<QuestionOptionInputCard> {
  final questionOptionFormKey = GlobalKey<FormState>();

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
            width: ScreenUtil()
                .setWidth(widget.width == null ? 1050 : widget.width + 200),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 40, top: 13),
                  child: Form(
                    key: questionOptionFormKey,
                    child: SizedBox(
                      width: ScreenUtil()
                          .setWidth(widget.width == null ? 850 : widget.width),
                      height: 75,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Required field, cannot be blank';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          if (questionOptionFormKey.currentState.validate()) {
                            QuestionOptionInputCard._controller.clear();
                            Momentum.controller<QuizBuilderController>(context)
                                .newOption(
                                    questionId: widget.questionId,
                                    optionValue: quizBuilder
                                        .questions[widget.questionId]
                                        .currentOptionInput);
                          }
                        },
                        controller: QuestionOptionInputCard._controller,
                        onChanged: (value) {
                          Momentum.controller<QuizBuilderController>(context)
                              .editOption(
                                  questionID: widget.questionId,
                                  optionValue: value);
                        },
                        cursorColor: Color.fromARGB(255, 97, 211, 87),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 97, 211, 87),
                                  width: 2.0),
                            ),
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(fontSize: 20),
                            hintText: widget.hint == null
                                ? "Enter answer option..."
                                : widget.hint),
                      ),
                    ),
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Icon(Icons.add,
                        size: 40, color: Color.fromARGB(255, 97, 211, 87)),
                    onTap: () {
                      if (questionOptionFormKey.currentState.validate()) {
                        QuestionOptionInputCard._controller.clear();

                        Momentum.controller<QuizBuilderController>(context)
                            .newOption(
                                questionId: widget.questionId,
                                optionValue: quizBuilder
                                    .questions[widget.questionId]
                                    .currentOptionInput);
                      }
                    },
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
