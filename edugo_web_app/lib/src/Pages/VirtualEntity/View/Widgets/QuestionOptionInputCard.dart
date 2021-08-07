import 'package:edugo_web_app/src/Pages/EduGo.dart';

class QuestionOptionInputCard extends StatelessWidget {
  final int questionId;
  static var _controller = TextEditingController();

  const QuestionOptionInputCard({Key key, this.questionId}) : super(key: key);

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
            child: Row(
              children: [
                SizedBox(
                  width: ScreenUtil().setWidth(800),
                  height: 60,
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      Momentum.controller<QuizBuilderController>(context)
                          .editOption(
                              questionID: questionId, optionValue: value);
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
                        hintText: "Enter answer option..."),
                  ),
                ),
                Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Icon(Icons.add,
                        size: 40, color: Color.fromARGB(255, 97, 211, 87)),
                    onTap: () {
                      _controller.clear();
                      Momentum.controller<QuizBuilderController>(context)
                          .newOption(
                              questionId: questionId,
                              optionValue: quizBuilder
                                  .questions[questionId].currentOptionInput);
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
