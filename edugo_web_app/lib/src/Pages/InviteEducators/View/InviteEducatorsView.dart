import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/InviteEducators/View/Widgets/InviteEducatorsWidgets.dart';

class InviteEducatorsView extends StatefulWidget {
  @override
  _InviteEducatorsViewState createState() => _InviteEducatorsViewState();
}

class _InviteEducatorsViewState extends State<InviteEducatorsView> {
  void _invitationsSent() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          insetPadding:
              EdgeInsets.only(top: 100, bottom: 100, left: 100, right: 100),
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Icon(
                  Icons.done_rounded,
                  color: Color.fromARGB(255, 97, 211, 87),
                  size: 100,
                ),
              ),
              Center(
                child: new Text(
                  'Invitations successfully sent',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                  child: MaterialButton(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                minWidth: ScreenUtil().setWidth(150),
                height: 50,
                child: Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                color: Color.fromARGB(255, 97, 211, 87),
                disabledColor: Color.fromRGBO(211, 212, 217, 1),
              )),
            ),
          ],
        );
      },
    );
  }

  void _invitationsNotSent() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          insetPadding:
              EdgeInsets.only(top: 100, bottom: 100, left: 100, right: 100),
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                  size: 100,
                ),
              ),
              Center(
                child: new Text(
                  'Could not send invitations',
                  style: TextStyle(fontSize: 22, color: Colors.red),
                ),
              ),
            ],
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Center(
                  child: new Text(
                    'A server error might have occurred, Please try again.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                  child: MaterialButton(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                minWidth: ScreenUtil().setWidth(150),
                height: 50,
                child: Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                color: Color.fromARGB(255, 97, 211, 87),
                disabledColor: Color.fromRGBO(211, 212, 217, 1),
              )),
            ),
          ],
        );
      },
    );
  }

  void _emptyEmailError() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          insetPadding:
              EdgeInsets.only(top: 100, bottom: 100, left: 100, right: 100),
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                  size: 100,
                ),
              ),
              Center(
                child: new Text(
                  'Could not send invitations',
                  style: TextStyle(fontSize: 22, color: Colors.red),
                ),
              ),
            ],
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Center(
                  child: new Text(
                    'Please add all information and try again!',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                  child: MaterialButton(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                minWidth: ScreenUtil().setWidth(150),
                height: 50,
                child: Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                color: Color.fromARGB(255, 97, 211, 87),
                disabledColor: Color.fromRGBO(211, 212, 217, 1),
              )),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Momentum.controller<InviteEducatorsController>(context).reset();
    return MomentumBuilder(
        controllers: [InviteEducatorsController],
        builder: (context, snapshot) {
          var educators = snapshot<InviteEducatorsModel>();
          Future<String> loader = Future<String>.delayed(
            const Duration(seconds: 1),
            () {
              return "Data loaded";
            },
          );
          Future<String> sendingInvitations = Future<String>.delayed(
            const Duration(seconds: 0),
            () {
              if (educators.inviteResponse.isEmpty) return null;
              return educators.inviteResponse;
            },
          );

          return FutureBuilder(
            future: loader,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData)
                return PageLayout(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: FutureBuilder(
                    future: sendingInvitations,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          padding: EdgeInsets.only(left: 100, right: 100),
                          child: ListView(
                            padding: EdgeInsets.only(
                                top: 50, bottom: 50, left: 25, right: 25),
                            children: <Widget>[
                              Material(
                                elevation: 40,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: ScreenUtil().setWidth(1100),
                                  padding: EdgeInsets.only(
                                      left: 50, right: 50, top: 50, bottom: 50),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                              color: Color.fromARGB(
                                                  255, 97, 211, 87),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: EducatorsEmailInputCard(),
                                          ),
                                          InviteEducatorsButton(
                                              elevation: 40,
                                              child: Text(
                                                "Upload csv",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Momentum.controller<
                                                            InviteEducatorsController>(
                                                        context)
                                                    .selectCSVFile(context);
                                              },
                                              width: 200,
                                              height: 65),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        children: educators.emailCards,
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      InviteEducatorsButton(
                                          elevation: 40,
                                          child: Text(
                                            "Send Invitations",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            if (educators.emails.isEmpty)
                                              _emptyEmailError();
                                            else
                                              await Momentum.controller<
                                                          InviteEducatorsController>(
                                                      context)
                                                  .sendInvitations(context)
                                                  .then(
                                                (value) {
                                                  if (value ==
                                                      "Invitations not sent")
                                                    _invitationsNotSent();
                                                  if (value ==
                                                      "Invitations sent") {
                                                    _invitationsSent();
                                                    Momentum.controller<
                                                                InviteEducatorsController>(
                                                            context)
                                                        .reset();
                                                  }
                                                },
                                              );
                                          },
                                          width: 450,
                                          height: 65),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Scaffold(
                        body: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Color.fromARGB(255, 97, 211, 87)),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sending ",
                                    style: TextStyle(fontSize: 28),
                                  ),
                                  Text(
                                    "edu",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 97, 211, 87),
                                        fontSize: 28),
                                  ),
                                  Text(
                                    "cators invitations...",
                                    style: TextStyle(fontSize: 28),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 97, 211, 87)),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Getting ",
                            style: TextStyle(fontSize: 28),
                          ),
                          Text(
                            "rea",
                            style: TextStyle(
                                color: Color.fromARGB(255, 97, 211, 87),
                                fontSize: 28),
                          ),
                          Text(
                            "dy...",
                            style: TextStyle(fontSize: 28),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
