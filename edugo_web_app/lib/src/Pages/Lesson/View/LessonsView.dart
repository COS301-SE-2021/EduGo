import 'package:edugo_web_app/src/Pages/EduGo.dart';

class LessonsView extends StatefulWidget {
  const LessonsView({Key key}) : super(key: key);

  @override
  State<LessonsView> createState() => _LessonsViewState();
}

class _LessonsViewState extends State<LessonsView> {
  bool plublished = true;
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [],
        builder: (context, snapshot) {
          return PageLayout(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 0),
                  child: ListView(
                    padding: EdgeInsets.only(
                      top: 0,
                    ),
                    children: <Widget>[
                      StickyHeader(
                        header: Material(
                          elevation: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.only(
                                right: 50, left: 100, top: 25, bottom: 25),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Created Lessons",
                                      style: TextStyle(
                                        fontSize: 32,
                                      ),
                                    ),
                                    Spacer(),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            plublished = !plublished;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            bottom:
                                                5, // Space between underline and text
                                          ),
                                          decoration: plublished
                                              ? BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 97, 211, 87),
                                                      width:
                                                          4.0, // Underline thickness
                                                    ),
                                                  ),
                                                )
                                              : BoxDecoration(),
                                          child: Text(
                                            "Published",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            plublished = !plublished;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            bottom:
                                                5, // Space between underline and text
                                          ),
                                          decoration: !plublished
                                              ? BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 97, 211, 87),
                                                      width:
                                                          4.0, // Underline thickness
                                                    ),
                                                  ),
                                                )
                                              : BoxDecoration(),
                                          child: Text(
                                            "Unpublished",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    LessonButton(
                                      onPressed: () {
                                        MomentumRouter.goto(
                                            context, CreateLessonView);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            "Create Lesson",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      width: 250,
                                      height: 60,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        content: plublished
                            ? GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                primary: false,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(
                                    right: 30, left: 30, top: 40, bottom: 80),
                                crossAxisSpacing: 40,
                                mainAxisSpacing: 40,
                                crossAxisCount: 4,
                                childAspectRatio: 1 / 1.1,
                                children: [
                                  LessonCard(
                                    title: "Mathematics",
                                  ),
                                  LessonCard(
                                    title: "Mathematics",
                                  ),
                                  LessonCard(
                                    title: "Mathematics",
                                  ),
                                  LessonCard(
                                    title: "Mathematics",
                                  ),
                                  LessonCard(
                                    title: "Mathematics",
                                  ),
                                  LessonCard(
                                    title: "Mathematics",
                                  ),
                                  LessonCard(
                                    title: "Mathematics",
                                  ),
                                  LessonCard(
                                    title: "Mathematics",
                                  ),
                                  LessonCard(
                                    title: "Mathematics",
                                  ),
                                  LessonCard(
                                    title: "Mathematics",
                                  ),
                                  LessonCard(
                                    title: "Mathematics",
                                  ),
                                  LessonCard(
                                    title: "Mathematics",
                                  ),
                                  LessonCard(
                                    title: "Mathematics",
                                  ),
                                  LessonCard(
                                    title: "Mathematics",
                                  ),
                                ],
                              )
                            : GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                primary: false,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(
                                    right: 30, left: 30, top: 40, bottom: 80),
                                crossAxisSpacing: 40,
                                mainAxisSpacing: 40,
                                crossAxisCount: 4,
                                childAspectRatio: 1 / 1.1,
                                children: [
                                  LessonCard(
                                    title: "English",
                                  ),
                                  LessonCard(
                                    title: "English",
                                  ),
                                  LessonCard(
                                    title: "English",
                                  ),
                                  LessonCard(
                                    title: "English",
                                  ),
                                  LessonCard(
                                    title: "English",
                                  ),
                                  LessonCard(
                                    title: "English",
                                  ),
                                  LessonCard(
                                    title: "English",
                                  ),
                                  LessonCard(
                                    title: "English",
                                  ),
                                  LessonCard(
                                    title: "English",
                                  ),
                                  LessonCard(
                                    title: "English",
                                  ),
                                  LessonCard(
                                    title: "English",
                                  ),
                                  LessonCard(
                                    title: "English",
                                  ),
                                  LessonCard(
                                    title: "English",
                                  ),
                                  LessonCard(
                                    title: "English",
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
