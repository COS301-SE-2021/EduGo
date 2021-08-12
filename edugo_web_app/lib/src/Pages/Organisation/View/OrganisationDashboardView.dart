import 'package:edugo_web_app/src/Pages/EduGo.dart';

class OrganisationDashboardView extends StatelessWidget {
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [CurrentOrganisationController],
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 80.0, bottom: 70, left: 100),
                        child: Text(
                          "Welcome to University of Pretoria",
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 100, left: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              elevation: 40,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  height: 110,
                                  padding: EdgeInsets.only(
                                      right: 20,
                                      left: 100,
                                      top: 25,
                                      bottom: 25),
                                  child: Container(
                                    child: Text(
                                      "Invite Educator",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  )),
                            ),
                            Spacer(),
                            Material(
                              elevation: 40,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  height: 110,
                                  padding: EdgeInsets.only(
                                      right: 20,
                                      left: 100,
                                      top: 25,
                                      bottom: 25),
                                  child: Container(
                                    child: Text(
                                      "Invite Student",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  )),
                            ),
                            Spacer(),
                            Material(
                              elevation: 40,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  height: 110,
                                  padding: EdgeInsets.only(
                                      right: 20,
                                      left: 100,
                                      top: 25,
                                      bottom: 25),
                                  child: Container(
                                    child: Text(
                                      "Manage Educators",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  )),
                            ),
                            Spacer(),
                            Material(
                              elevation: 40,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  height: 110,
                                  padding: EdgeInsets.only(
                                      right: 20,
                                      left: 100,
                                      top: 25,
                                      bottom: 25),
                                  child: Container(
                                    child: Text(
                                      "Manage Virtual Entities",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  )),
                            )
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
