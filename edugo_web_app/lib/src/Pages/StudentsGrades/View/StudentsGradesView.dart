import 'package:edugo_web_app/src/Pages/EduGo.dart';

class StudentsGradesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Info: Getting educator lessons from API
    Momentum.controller<StudentsGradesController>(context)
        .getEducatorGrades(context);
    //Info: Buiding lessons user interface
    return MomentumBuilder(
      controllers: [StudentsGradesController],
      builder: (context, snapshot) {
        //Info: reading lesson cards from model
        var educatorGrades = snapshot<StudentsGradesModel>();
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
                                      value: educatorGrades.currentSubject,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 40,
                                      underline: Container(
                                        height: 2,
                                        color: Color.fromARGB(255, 97, 211, 87),
                                      ),
                                      elevation: 20,
                                      onChanged: (String name) {
                                        Momentum.controller<
                                                    StudentsGradesController>(
                                                context)
                                            .selectSubject(name: name);
                                      },
                                      items: educatorGrades.subjectsStrings
                                          .map<DropdownMenuItem<String>>(
                                        (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: SizedBox(
                                              width: ScreenUtil().setWidth(300),
                                              child: Text(
                                                value,
                                                overflow: TextOverflow.visible,
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
                        children: educatorGrades.studentCards,
                      ),
                    ),
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
