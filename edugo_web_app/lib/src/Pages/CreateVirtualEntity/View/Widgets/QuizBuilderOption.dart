import 'package:edugo_web_app/src/Pages/EduGo.dart';

class QuizBuilderOption extends StatelessWidget {
  final int questionId;
  final int optionId;
  final double width;
  final String optionValue;
  final Function onDelete;
  const QuizBuilderOption(
      {Key key,
      this.questionId,
      this.optionId,
      this.optionValue,
      this.onDelete,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CreateVirtualEntityController, QuizBuilderController],
      builder: (context, snapshot) {
        return Material(
          elevation: 40,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: width != null ? ScreenUtil().setWidth(width) : null,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: ScreenUtil().setWidth(300),
                      child: Text(
                        optionValue,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Icon(Icons.delete,
                        size: 40, color: Color.fromARGB(255, 97, 211, 87)),
                    onTap: () {
                      if (onDelete == null)
                        Momentum.controller<QuizBuilderController>(context)
                            .removeOption(
                                questionId: questionId, optionId: optionId);
                      else {
                        onDelete(questionId, optionId);
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
