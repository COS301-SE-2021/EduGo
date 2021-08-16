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
        controllers: [CurrentOrganisationController],
        builder: (context, snapshot) {
          var currentOrgnisation = snapshot<CurrentOrganisationModel>();
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
                          content: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            primary: false,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                                right: 30, left: 30, top: 50, bottom: 80),
                            children: currentOrgnisation.lessonsView,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
