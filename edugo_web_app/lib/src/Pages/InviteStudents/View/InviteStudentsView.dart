import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/InviteStudents/View/Widgets/InviteStudentsWidgets.dart';

class InviteStudentsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [
          InviteStudentsController,
          SubjectsController,
          AdminController
        ],
        builder: (context, snapshot) {
          var students = snapshot<InviteStudentsModel>();
          var subjects = snapshot<SubjectsModel>();
          return PageLayout(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(left: 100, right: 100),
              child: ListView(
                padding: EdgeInsets.only(top: 50),
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
                              Spacer(),
                              Align(
                                alignment: Alignment.topLeft,
                                child: DropdownButton<String>(
                                  hint: Text("Choose subject"),
                                  value: students.subjectName,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 40,
                                  underline: Container(
                                    height: 2,
                                    color: Color.fromARGB(255, 97, 211, 87),
                                  ),
                                  elevation: 20,
                                  onChanged: (String name) {
                                    Momentum.controller<
                                            InviteStudentsController>(context)
                                        .inputSubjectName(name);
                                    Momentum.controller<AdminController>(
                                            context)
                                        .setCurrentSubjectId(
                                            Momentum.controller<
                                                    SubjectsController>(context)
                                                .getSubjectIdByName(name));
                                  },
                                  items: Momentum.controller<
                                          InviteStudentsController>(context)
                                      .getSubjectsString(subjects.subjects)
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
                              onPressed: () {
                                Momentum.controller<InviteStudentsController>(
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
