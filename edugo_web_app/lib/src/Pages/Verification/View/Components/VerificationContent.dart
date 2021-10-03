import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Login/View/Widgets/LogInWidgets.dart';

class VerificationContent extends StatefulWidget {
  VerificationContent() : super(key: Key("LogInContent"));

  @override
  _VerificationContentState createState() => _VerificationContentState();
}

class _VerificationContentState extends State<VerificationContent> {
  final _formKey = GlobalKey<FormState>();

  void _unInvited() {
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
                  'Invalid Verification Credentials',
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
          controllers: [VerificationController],
          builder: (context, snapshot) {
            Momentum.controller<VerificationController>(context)
                .resetErrorString();
            var errorStringFetch = snapshot<VerificationModel>();

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
                              onFieldSubmitted: (input) async {
                                if (_formKey.currentState.validate())
                                  await Momentum.controller<
                                          VerificationController>(context)
                                      .verifyUser()
                                      .then(
                                    (value) {
                                      if (value == "Invalid Credentials") {
                                        _unInvited();
                                      } else {
                                        MomentumRouter.goto(
                                            context, RegisterView);
                                      }
                                    },
                                  );
                              },
                              validator: MultiValidator(
                                [
                                  RequiredValidator(errorText: "* Required"),
                                  LengthRangeValidator(
                                      min: 5,
                                      max: 5,
                                      errorText: 'Invalid Code'),
                                  PatternValidator(r'^[0-9]*$',
                                      errorText: "Invalid Code"),
                                ],
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                Momentum.controller<VerificationController>(
                                        context)
                                    .setVerificationCode(value);
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
                                hintText: "Verificaction Code",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(600),
                            height: 100,
                            child: TextFormField(
                              onFieldSubmitted: (input) async {
                                if (_formKey.currentState.validate())
                                  await Momentum.controller<
                                          VerificationController>(context)
                                      .verifyUser()
                                      .then(
                                    (value) {
                                      if (value == "Invalid Credentials") {
                                        _unInvited();
                                      } else {
                                        MomentumRouter.goto(
                                            context, RegisterView);
                                      }
                                    },
                                  );
                              },
                              validator: MultiValidator(
                                [
                                  RequiredValidator(errorText: "* Required"),
                                  PatternValidator(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                      errorText: "Invalid Email"),
                                ],
                              ),
                              onChanged: (value) {
                                Momentum.controller<VerificationController>(
                                        context)
                                    .setVerificationEmail(value);
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
                                hintText: "Email",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          LogInButton(
                              elevation: 40,
                              child: Text(
                                "Verify",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate())
                                  await Momentum.controller<
                                          VerificationController>(context)
                                      .verifyUser()
                                      .then(
                                    (value) {
                                      if (value == "Invalid Credentials") {
                                        _unInvited();
                                      } else {
                                        MomentumRouter.goto(
                                            context, RegisterView);
                                      }
                                    },
                                  );
                              },
                              width: 600,
                              height: 65),
                          SizedBox(
                            height: 30,
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Already Verified?  "),
                                GestureDetector(
                                  onTap: () {
                                    MomentumRouter.goto(context, LogInView);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      bottom:
                                          3, // This can be the space you need betweeb text and underline
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.blue,
                                          width:
                                              1.0, // This would be the width of the underline
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
