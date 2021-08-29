import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/StudentsGrades/View/Widgets/StudentsGradesWidgets.dart';

class StudentsGradesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Info: Getting educator lessons from API
    // Momentum.controller<LessonsController>(context).getSubjectLessons(context);

    //Info: Buiding lessons user interface
    return MomentumBuilder(
        controllers: [LessonsController],
        builder: (context, snapshot) {
          //Info: reading lesson cards from model
          // var educatorLessons = snapshot<LessonsModel>();
          List<String> mock = ["1", "2", "3", "4"];
          //Info: rendering lesson cards
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
                                        "Student Progress",
                                        style: TextStyle(
                                          fontSize: 32,
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: DropdownButton<String>(
                                          hint: Text("Filter by subject"),
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          iconSize: 40,
                                          underline: Container(
                                            height: 2,
                                            color: Color.fromARGB(
                                                255, 97, 211, 87),
                                          ),
                                          elevation: 20,
                                          onChanged: (String name) {},
                                          items: mock
                                              .map<DropdownMenuItem<String>>(
                                            (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: SizedBox(
                                                  width: ScreenUtil()
                                                      .setWidth(300),
                                                  child: Text(
                                                    value,
                                                    overflow:
                                                        TextOverflow.visible,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
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
                            children: [
                              StudentsGradesCard(
                                grade: 10,
                                name: "noah",
                              ),
                              StudentsGradesCard(
                                grade: 50,
                                name: "tshepo",
                              )
                            ],
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
