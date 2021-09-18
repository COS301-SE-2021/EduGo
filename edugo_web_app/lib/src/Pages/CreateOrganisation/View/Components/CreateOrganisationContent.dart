import 'package:edugo_web_app/src/Pages/CreateOrganisation/View/Widgets/CreateOrganisationButton.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateOrganisationContent extends StatefulWidget {
  @override
  _CreateOrganisationContentState createState() =>
      _CreateOrganisationContentState();
}

class _CreateOrganisationContentState extends State<CreateOrganisationContent> {
  final _formKey = GlobalKey<FormState>();

  void _organisationNotCreated() {
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
                  color: Colors.amber,
                  size: 100,
                ),
              ),
              Center(
                child: new Text(
                  'A server error occurred.',
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
                    'Please try again.',
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
    return MomentumBuilder(
      controllers: [CreateOrganisationController],
      builder: (context, snapshot) {
        var organisation = snapshot<CreateOrganisationModel>();
        return Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 100.0),
                child: Material(
                  elevation: 40,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 600,
                    padding: EdgeInsets.only(top: 50),
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
                                Text(
                                  "Go",
                                  style: TextStyle(
                                      fontSize: 50,
                                      color: Color.fromARGB(255, 97, 211, 87),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 90.0, vertical: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Organisation",
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
                                return 'Organisation name cannot be blank';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (value != null)
                                Momentum.controller<
                                        CreateOrganisationController>(context)
                                    .inputName(value);
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
                              hintText: "Organisation Name",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 400,
                          height: 100,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Organisation email cannot be blank';
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
                                Momentum.controller<
                                        CreateOrganisationController>(context)
                                    .inputEmail(value);
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
                              hintText: "Organisation Email",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 400,
                          height: 100,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Organisation phone number cannot be blank';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (value != null)
                                Momentum.controller<
                                        CreateOrganisationController>(context)
                                    .inputPhoneNumber(value);
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
                              hintText: "Phone Number",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 90.0, vertical: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Organisation Admin",
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
                                return 'Admin first name cannot be blank';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (value != null)
                                Momentum.controller<
                                        CreateOrganisationController>(context)
                                    .inputAdminFirstName(value);
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
                              hintText: "Admin First Name",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 400,
                          height: 100,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Admin last name cannot be blank';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (value != null)
                                Momentum.controller<
                                        CreateOrganisationController>(context)
                                    .inputAdminLastName(value);
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
                              hintText: "Admin Last Name",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 400,
                          height: 100,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Admin email cannot be blank';
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
                                Momentum.controller<
                                        CreateOrganisationController>(context)
                                    .inputAdminEmail(value);
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
                              hintText: "Admin Email",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 400,
                          height: 100,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Admin user name cannot be blank';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (value != null)
                                Momentum.controller<
                                        CreateOrganisationController>(context)
                                    .inputAdminUserName(value);
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
                              hintText: "Admin User Name",
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
                                return 'Password cannot be blank';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (value != null)
                                Momentum.controller<
                                        CreateOrganisationController>(context)
                                    .inputAdminPassword(value);
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
                              if (value != '${organisation.adminPassword}') {
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
                        CreateOrganisationButton(
                            elevation: 40,
                            child: Text(
                              "Create Organisation",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await Momentum.controller<
                                        CreateOrganisationController>(context)
                                    .createOrganisation()
                                    .then(
                                  (value) {
                                    if (value == "Organisation Created") {
                                      Momentum.controller<
                                                  CreateOrganisationController>(
                                              context)
                                          .loginUser(context);
                                    }
                                    if (value == "Organisation Not Created") {
                                      _organisationNotCreated();
                                      _formKey.currentState.reset();
                                    }
                                  },
                                );
                              }
                            },
                            width: 450,
                            height: 65),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
