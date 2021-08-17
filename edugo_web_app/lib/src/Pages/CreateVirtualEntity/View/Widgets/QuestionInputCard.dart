import 'package:edugo_web_app/src/Pages/EduGo.dart';

class QuestionInputCard extends StatelessWidget {
  final int questionId;

  const QuestionInputCard({Key key, this.questionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CreateVirtualEntityController, QuizBuilderController],
      builder: (context, snapshot) {
        return Material(
          elevation: 40,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SizedBox(
              width: ScreenUtil().setWidth(1000),
              height: 60,
              child: TextField(
                onChanged: (value) {
                  Momentum.controller<QuizBuilderController>(context)
                      .inputQuestion(questionId: questionId, question: value);
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
