import 'package:edugo_web_app/src/Pages/EduGo.dart';

class SentenceInputCard extends StatefulWidget {
  final int questionId;
  final double width;

  static var _controller = TextEditingController();

  SentenceInputCard({
    Key key,
    this.questionId,
    this.width,
  }) : super(key: key);

  @override
  _SentenceInputCardState createState() => _SentenceInputCardState();
}

class _SentenceInputCardState extends State<SentenceInputCard> {
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
                          if (quizBuilder.questions[widget.questionId]
                                  .missingWordCount ==
                              null) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return new AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  insetPadding: EdgeInsets.only(
                                      top: 100,
                                      bottom: 100,
                                      left: 100,
                                      right: 100),
                                  title: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Icon(
                                          Icons.warning_rounded,
                                          color: Colors.red,
                                          size: 100,
                                        ),
                                      ),
                                      Center(
                                        child: new Text(
                                          'Number of missing words error.',
                                          style: TextStyle(
                                              fontSize: 22, color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                  content: new SingleChildScrollView(
                                    child: new ListBody(
                                      children: [
                                        Center(
                                          child: new Text(
                                            'Please select number of missing words and try again.',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Center(
                                        child: MaterialButton(
                                          elevation: 20,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          minWidth: ScreenUtil().setWidth(150),
                                          height: 50,
                                          child: Text(
                                            'Ok',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          color:
                                              Color.fromARGB(255, 97, 211, 87),
                                          disabledColor:
                                              Color.fromRGBO(211, 212, 217, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (questionOptionFormKey.currentState
                              .validate()) {
                            SentenceInputCard._controller.clear();
                            Momentum.controller<QuizBuilderController>(context)
                                .newSentence(
                              context,
                              questionId: widget.questionId,
                            );
                          }
                        },
                        controller: SentenceInputCard._controller,
                        onChanged: (value) {
                          Momentum.controller<QuizBuilderController>(context)
                              .editSentence(
                                  questionID: widget.questionId,
                                  sentenceValue: value);
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
                            hintText: "Enter partial sentence..."),
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
                      if (quizBuilder
                              .questions[widget.questionId].missingWordCount ==
                          null) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return new AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              insetPadding: EdgeInsets.only(
                                  top: 100, bottom: 100, left: 100, right: 100),
                              title: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Icon(
                                      Icons.warning_rounded,
                                      color: Colors.red,
                                      size: 100,
                                    ),
                                  ),
                                  Center(
                                    child: new Text(
                                      'Number of missing words error.',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                              content: new SingleChildScrollView(
                                child: new ListBody(
                                  children: [
                                    Center(
                                      child: new Text(
                                        'Please select number of missing words and try again.',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Center(
                                    child: MaterialButton(
                                      elevation: 20,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      minWidth: ScreenUtil().setWidth(150),
                                      height: 50,
                                      child: Text(
                                        'Ok',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      color: Color.fromARGB(255, 97, 211, 87),
                                      disabledColor:
                                          Color.fromRGBO(211, 212, 217, 1),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (questionOptionFormKey.currentState
                          .validate()) {
                        SentenceInputCard._controller.clear();
                        Momentum.controller<QuizBuilderController>(context)
                            .newSentence(
                          context,
                          questionId: widget.questionId,
                        );
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
