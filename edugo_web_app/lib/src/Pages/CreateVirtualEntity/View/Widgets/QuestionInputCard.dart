import 'package:edugo_web_app/src/Pages/EduGo.dart';

class QuestionInputCard extends StatefulWidget {
  final int questionId;
  final GlobalKey<FormState> questionFormKey;
  final Function onSubmit;
  const QuestionInputCard(
      {Key key, this.questionId, this.questionFormKey, this.onSubmit})
      : super(key: key);

  @override
  _QuestionInputCardState createState() => _QuestionInputCardState();
}

class _QuestionInputCardState extends State<QuestionInputCard> {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CreateVirtualEntityController, QuizBuilderController],
      builder: (context, snapshot) {
        return Material(
          elevation: 40,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.only(top: 25, bottom: 5, right: 20, left: 20),
            child: SizedBox(
              width: ScreenUtil().setWidth(1000),
              height: 75,
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Required field, cannot be blank';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  if (widget.questionFormKey.currentState.validate())
                    widget.onSubmit();
                },
                onChanged: (value) {
                  Momentum.controller<QuizBuilderController>(context)
                      .inputQuestion(
                          questionId: widget.questionId, question: value);
                },
                cursorColor: Color.fromARGB(255, 97, 211, 87),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 20),
                    hintText: "Enter question..."),
              ),
            ),
          ),
        );
      },
    );
  }
}
