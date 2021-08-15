import 'package:edugo_web_app/src/Pages/EduGo.dart';

class EducatorCard extends StatelessWidget {
  final bool admin;
  const EducatorCard({Key key, this.admin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [VirtualEntityApiController, QuizBuilderController],
      builder: (context, snapshot) {
        return Material(
          elevation: 40,
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 97, 211, 87),
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
                        "Mr Noah",
                        overflow: TextOverflow.visible,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                admin
                    ? Container(
                        decoration: BoxDecoration(border: Border()),
                        height: 60,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Revoke Admin",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(border: Border()),
                        height: 60,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Make Admin",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
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
