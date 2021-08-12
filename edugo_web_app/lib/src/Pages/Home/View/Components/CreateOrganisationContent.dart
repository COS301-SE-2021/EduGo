import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateOrganisationContent extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  List<Widget> pageChildren(double width, context, bool spacer, organisation) {
    return <Widget>[
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
                Row(
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
                            color: Color.fromARGB(255, 97, 211, 87),
                            fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 50,
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
                      Momentum.controller<OrganisationController>(context)
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
                      Momentum.controller<OrganisationController>(context)
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
                      Momentum.controller<OrganisationController>(context)
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
                      Momentum.controller<OrganisationController>(context)
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
                      Momentum.controller<OrganisationController>(context)
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
                      Momentum.controller<OrganisationController>(context)
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
                      Momentum.controller<OrganisationController>(context)
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
                      Momentum.controller<OrganisationController>(context)
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
                      if (value != '${organisation.adminPassword}')
                        return 'Passwords do not match';
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
                VirtualEntityButton(
                    elevation: 40,
                    child: Text(
                      "Create Organisation",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _formKey.currentState.validate();
                      Momentum.controller<OrganisationController>(context)
                          .createOrganisation(context);
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return MomentumBuilder(
            controllers: [OrganisationController],
            builder: (context, snapshot) {
              var organisation = snapshot<OrganisationModel>();
              return Form(
                key: _formKey,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: pageChildren(constraints.biggest.width / 2,
                        context, true, organisation)),
              );
            });
      } else {
        return MomentumBuilder(
            controllers: [OrganisationController],
            builder: (context, snapshot) {
              var organisation = snapshot<OrganisationModel>();
              return Form(
                key: _formKey,
                child: Column(
                    children: pageChildren(constraints.biggest.width, context,
                        false, organisation)),
              );
            });
      }
    });
  }
}


// (spacer)
//           ? Padding(
//               padding: const EdgeInsets.symmetric(vertical: 1.0),
//               child: Image.asset(
//                 "../assets/images/EduGoTree.png",
//                 width: width,
//                 height: 665,
//               ),
//             )
//           : SizedBox(),
//       (spacer) ? SizedBox() : SizedBox(),
//       SizedBox(
//         height: 200,
//       ),