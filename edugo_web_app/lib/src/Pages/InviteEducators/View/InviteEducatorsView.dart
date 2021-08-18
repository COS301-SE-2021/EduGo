import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/InviteEducators/View/Widgets/InviteEducatorsWidgets.dart';

class InviteEducatorsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [InviteEducatorsController],
        builder: (context, snapshot) {
          return PageLayout(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(top: 50, left: 100, right: 100),
              child: ListView(
                children: <Widget>[
                  Material(
                    elevation: 40,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: ScreenUtil().setWidth(1100),
                      padding: EdgeInsets.only(
                          left: 50, right: 50, top: 50, bottom: 80),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Invite",
                                style: TextStyle(fontSize: 32),
                              ),
                              Text(
                                " Edu",
                                style: TextStyle(fontSize: 32),
                              ),
                              Text(
                                "cators",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  color: Color.fromARGB(255, 97, 211, 87),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          EducatorsEmailInputCard(),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children:
                                Momentum.controller<InviteEducatorsController>(
                                        context)
                                    .getEmailView(),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          InviteEducatorsButton(
                              elevation: 40,
                              child: Text(
                                "Send Invitations",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Momentum.controller<InviteEducatorsController>(
                                        context)
                                    .sendInvitations(context);
                              },
                              width: 450,
                              height: 65),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
