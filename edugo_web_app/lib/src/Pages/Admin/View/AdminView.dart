import 'package:edugo_web_app/src/Pages/Admin/View/Widgets/AdminWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class AdminView extends StatelessWidget {
  Widget build(BuildContext context) {
    Momentum.controller<AdminController>(context).getOrganisationId(context);
    return MomentumBuilder(
        controllers: [AdminController],
        builder: (context, snapshot) {
          var currentOrganisation = snapshot<AdminModel>();
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
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          bottom:
                                              5, // Space between underline and text
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 97, 211, 87),
                                              width: 4.0, // Underline thickness
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          currentOrganisation.organisationName,
                                          style: TextStyle(
                                            fontSize: 35,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    AdminButton(
                                      onPressed: () {
                                        MomentumRouter.goto(
                                            context, InviteStudentsView);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                            "Invite Students",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      width: 230,
                                      height: 60,
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(40),
                                    ),
                                    AdminButton(
                                      onPressed: () {
                                        MomentumRouter.goto(
                                            context, InviteEducatorsView);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                            "Invite Educators",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      width: 230,
                                      height: 60,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        content: Container(
                          padding: EdgeInsets.symmetric(horizontal: 100),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 50,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Educators",
                                  style: TextStyle(
                                    fontSize: 32,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Column(
                                children: currentOrganisation.educatorCards,
                              )
                            ],
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
