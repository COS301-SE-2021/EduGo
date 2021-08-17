import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/InviteStudents/View/Widgets/InviteStudentsWidgets.dart';

class InviteStudentsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [InviteStudentsController],
        builder: (context, snapshot) {
          return PageLayout(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(top: 50),
              child: ListView(
                children: <Widget>[
                  Material(
                    elevation: 40,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: ScreenUtil().setWidth(1100),
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 30, bottom: 70),
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
                                " Stu",
                                style: TextStyle(fontSize: 32),
                              ),
                              Text(
                                "dents",
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
                          StudentsEmailInputCard(),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children:
                                Momentum.controller<InviteStudentsController>(
                                        context)
                                    .getEmailView(),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          InviteStudentsButton(
                              elevation: 40,
                              child: Text(
                                "Send Invitations",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {},
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
