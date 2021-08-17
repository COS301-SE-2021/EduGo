import 'package:edugo_web_app/src/Pages/EduGo.dart';

class InviteEmailCard extends StatelessWidget {
  final int emailId;
  final String emailValue;
  const InviteEmailCard({
    Key key,
    this.emailId,
    this.emailValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [VirtualEntityApiController, QuizBuilderController],
      builder: (context, snapshot) {
        return Material(
          elevation: 40,
          borderRadius: BorderRadius.circular(10),
          child: Container(
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
                        emailValue,
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
                      Momentum.controller<InviteEducatorController>(context)
                          .removeEmail(emailId);
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
