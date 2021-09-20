import 'package:edugo_web_app/main.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Verification/View/Widgets/VerificationWidgets.dart';

class RegisterContent extends StatefulWidget {
  @override
  _RegisterContentState createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
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
                  'Uninvited!',
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
                    'Please ensure that you\'re invited and try again.',
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
                  onPressed: () async {
                    await MomentumRouter.resetWithContext<Home>(context);
                    Momentum.restart(
                      context,
                      momentum(),
                    );
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

  void _alreadyRegistered() {
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
                  color: Colors.amber,
                  size: 100,
                ),
              ),
              Center(
                child: new Text(
                  'Already Registered.',
                  style: TextStyle(fontSize: 22, color: Colors.amber),
                ),
              ),
            ],
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Center(
                  child: new Text(
                    'A user with those credentials already exists.',
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
                  onPressed: () async {
                    await MomentumRouter.resetWithContext<Home>(context);
                    Momentum.restart(
                      context,
                      momentum(),
                    );
                  },
                  minWidth: ScreenUtil().setWidth(150),
                  height: 50,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.red,
                  disabledColor: Color.fromRGBO(211, 212, 217, 1),
                ),
              ),
            ),
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
                    MomentumRouter.goto(context, LogInView);
                  },
                  minWidth: ScreenUtil().setWidth(150),
                  height: 50,
                  child: Text(
                    'Sign In',
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
          controllers: [
            LogInController,
            VerificationController,
            AdminController
          ],
          builder: (context, snapshot) {
            Momentum.controller<VerificationController>(context)
                .resetErrorString();
            var user = snapshot<VerificationModel>();
            var organisation = snapshot<AdminModel>();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 90.0, bottom: 50.0),
                  child: Material(
                    elevation: 40,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: ScreenUtil().setWidth(800),
                      padding: EdgeInsets.only(top: 100, bottom: 50),
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
                                            color: Color.fromARGB(
                                                255, 97, 211, 87),
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 50),
                              child: Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Color.fromARGB(255, 97, 211, 87),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              height: 100,
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'First name cannot be blank';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value != null)
                                    Momentum.controller<VerificationController>(
                                            context)
                                        .setFirstName(value);
                                },
                                cursorColor: Color.fromARGB(255, 97, 211, 87),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 97, 211, 87),
                                        width: 2.0),
                                  ),
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(fontSize: 20),
                                  hintText: "First Name",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              height: 100,
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Last name cannot be blank';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value != null)
                                    Momentum.controller<VerificationController>(
                                            context)
                                        .setLastName(value);
                                },
                                cursorColor: Color.fromARGB(255, 97, 211, 87),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 97, 211, 87),
                                        width: 2.0),
                                  ),
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(fontSize: 20),
                                  hintText: "Last Name",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              height: 100,
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Email cannot be blank';
                                  }

                                  Pattern pattern =
                                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                      r"{0,253}[a-zA-Z0-9])?)*$";
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(value) || value == null)
                                    return 'Enter a valid email address';

                                  return null;
                                },
                                onChanged: (value) {
                                  if (value != null)
                                    Momentum.controller<VerificationController>(
                                            context)
                                        .setEmail(value);
                                },
                                cursorColor: Color.fromARGB(255, 97, 211, 87),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 97, 211, 87),
                                        width: 2.0),
                                  ),
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(fontSize: 20),
                                  hintText: "User Email",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              height: 100,
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'User name cannot be blank';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value != null)
                                    Momentum.controller<VerificationController>(
                                            context)
                                        .setUserName(value);
                                },
                                cursorColor: Color.fromARGB(255, 97, 211, 87),
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
                              width: 400,
                              height: 100,
                              child: TextFormField(
                                obscureText: true,
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "* Required"),
                                  MinLengthValidator(8,
                                      errorText: "Invalid password"),
                                  PatternValidator(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                      errorText:
                                          "Invalid password: should contain numbers & characters"),
                                ]),
                                onChanged: (value) {
                                  if (value != null)
                                    Momentum.controller<VerificationController>(
                                            context)
                                        .setPassword(value);
                                },
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
                              width: 400,
                              height: 100,
                              child: TextFormField(
                                obscureText: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Confirmation password cannot be blank';
                                  }
                                  if (value != '${user.password}') {
                                    return 'Passwords do not match';
                                  }

                                  return null;
                                },
                                cursorColor: Color.fromARGB(255, 97, 211, 87),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 97, 211, 87),
                                        width: 2.0),
                                  ),
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(fontSize: 20),
                                  hintText: "Confirm Password",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            VerificationButton(
                                elevation: 40,
                                child: Text(
                                  "Register",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    await Momentum.controller<
                                            VerificationController>(context)
                                        .registerUser()
                                        .then(
                                      (value) {
                                        if (value == "User Created") {
                                          Momentum.controller<
                                                      VerificationController>(
                                                  context)
                                              .loginUser(context: context);
                                        }
                                        if (value == "User Not Invited") {
                                          _unInvited();
                                        }
                                        if (value == "User Already Exists") {
                                          _alreadyRegistered();
                                        }
                                      },
                                    );
                                  }
                                },
                                width: 450,
                                height: 65),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
