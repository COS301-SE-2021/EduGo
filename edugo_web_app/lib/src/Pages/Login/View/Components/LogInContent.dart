import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Login/View/Widgets/LogInWidgets.dart';

class LogInContent extends StatefulWidget {
  LogInContent() : super(key: Key("LogInContent"));

  @override
  _LogInContentState createState() => _LogInContentState();
}

class _LogInContentState extends State<LogInContent> {
  final _formKey = GlobalKey<FormState>();

  void _unAuthorized() {
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
                  Icons.error_rounded,
                  color: Colors.red,
                  size: 100,
                ),
              ),
              Center(
                child: new Text(
                  'Invalid Credentials',
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
                    'Please enter the correct details and try again.',
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
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MomentumBuilder(
          controllers: [LogInController],
          builder: (context, snapshot) {
            Momentum.controller<LogInController>(context).resetErrorString();
            var errorStringFetch = snapshot<LoginModel>();

            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 90.0, bottom: 50.0),
                child: Material(
                  elevation: 40,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: ScreenUtil().setWidth(800),
                    height: ScreenUtil().setHeight(800),
                    padding: EdgeInsets.only(
                      top: 100,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                MomentumRouter.goto(context, Home);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Edu",
                                      style: TextStyle(
                                          fontSize: 50,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal)),
                                  Text("Go",
                                      style: TextStyle(
                                          fontSize: 50,
                                          color:
                                              Color.fromARGB(255, 97, 211, 87),
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(600),
                            height: 100,
                            child: TextFormField(
                              key: Key("LogInUserName"),
                              onFieldSubmitted: (value) async {
                                await Momentum.controller<LogInController>(
                                        context)
                                    .loginUser(
                                  context: context,
                                )
                                    .then(
                                  (value) {
                                    if (value == "Invalid Credentials") {
                                      _unAuthorized();
                                    }
                                  },
                                );
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'User name cannot be blank';
                                }
                                return errorStringFetch.errorString;
                              },
                              onChanged: (value) {
                                Momentum.controller<LogInController>(context)
                                    .setLoginUserName(value);
                              },
                              cursorColor: Color.fromARGB(255, 97, 211, 87),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 97, 211, 87),
                                      width: 2.0),
                                ),
                                border: OutlineInputBorder(),
                                hintStyle: TextStyle(fontSize: 20),
                                hintText: "User Name",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(600),
                            height: 100,
                            child: TextFormField(
                              key: Key("LogInPassword"),
                              onFieldSubmitted: (value) async {
                                await Momentum.controller<LogInController>(
                                        context)
                                    .loginUser(
                                  context: context,
                                )
                                    .then(
                                  (value) {
                                    if (value == "Invalid Credentials") {
                                      _unAuthorized();
                                    }
                                  },
                                );
                              },
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Password cannot be blank';
                                }

                                return errorStringFetch.errorString;
                              },
                              onChanged: (value) {
                                Momentum.controller<LogInController>(context)
                                    .setLoginPassword(value);
                              },
                              textAlign: TextAlign.center,
                              cursorColor: Color.fromARGB(255, 97, 211, 87),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 97, 211, 87),
                                      width: 2.0),
                                ),
                                border: OutlineInputBorder(),
                                hintStyle: TextStyle(fontSize: 20),
                                hintText: "Password",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          LogInButton(
                              elevation: 40,
                              child: Text(
                                "Sign In",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                await await Momentum.controller<
                                        LogInController>(context)
                                    .loginUser(
                                  context: context,
                                )
                                    .then(
                                  (value) {
                                    if (value == "Invalid Credentials") {
                                      _unAuthorized();
                                    }
                                  },
                                );
                              },
                              width: 600,
                              height: 65),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
