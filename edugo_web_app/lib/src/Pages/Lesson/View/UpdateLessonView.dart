import 'package:edugo_web_app/src/Pages/EduGo.dart';

class UpdateLessonView extends StatelessWidget {
  UpdateLessonView();
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [LessonController],
      builder: (context, snapshot) {
        return PageLayout(
          top: 50,
          left: 150,
          right: 150,
          child: Stack(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Lesson title",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topRight,
                    child: LessonButton(
                        child: Text("Delete Lesson",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {},
                        width: 200,
                        height: 50),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 60),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 70, left: 20, right: 20),
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                        elevation: 40,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: LessonInputBox(
                              text: "Lesson title...",
                            ))),
                    SizedBox(
                      height: 30,
                    ),
                    Material(
                      elevation: 40,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: LessonMultiLine(
                            text: "Lesson description...",
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 40,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 40),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(400),
                                height: 300,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                  child: Image.asset(
                                    "../assets/images/maths.jpeg",
                                  ),
                                ),
                              ),
                              Spacer(),
                              SubjectButton(
                                  child: Text(
                                    "Change Virtual Entity",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {},
                                  width: 400,
                                  height: 65),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 40,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 40),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(400),
                                height: 300,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                  child: Image.asset(
                                    "../assets/images/maths.jpeg",
                                  ),
                                ),
                              ),
                              Spacer(),
                              SubjectButton(
                                  child: Text(
                                    "Change Virtual Entity",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {},
                                  width: 400,
                                  height: 65),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    LessonButton(
                        child: Text("Update Lesson",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {},
                        width: 400,
                        height: 65),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
