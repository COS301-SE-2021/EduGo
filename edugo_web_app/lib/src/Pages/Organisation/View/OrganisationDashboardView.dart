import 'package:edugo_web_app/src/Pages/EduGo.dart';

class OrganisationDashboardView extends StatelessWidget {
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
                                Text(
                                  "Welcome to " +
                                      Momentum.controller<
                                                  CurrentOrganisationController>(
                                              context)
                                          .getOrganisationName(),
                                  style: TextStyle(
                                    fontSize: 32,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
