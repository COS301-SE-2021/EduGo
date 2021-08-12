import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateOrganisationContent extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  List<Widget> pageChildren(
    double width,
    context,
    bool spacer,
  ) {
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
                  height: 60,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      Momentum.controller<ViewBoundOrganisationController>(
                              context)
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
                  height: 20,
                ),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: TextField(
                    onChanged: (value) {
                      Momentum.controller<ViewBoundOrganisationController>(
                              context)
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
                  height: 20,
                ),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: TextField(
                    onChanged: (value) {
                      Momentum.controller<ViewBoundOrganisationController>(
                              context)
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
                  height: 20,
                ),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: TextField(
                    onChanged: (value) {
                      Momentum.controller<ViewBoundOrganisationController>(
                              context)
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
                  height: 20,
                ),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: TextField(
                    onChanged: (value) {
                      Momentum.controller<ViewBoundOrganisationController>(
                              context)
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
                  height: 20,
                ),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: TextField(
                    onChanged: (value) {
                      Momentum.controller<ViewBoundOrganisationController>(
                              context)
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
                  height: 20,
                ),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: TextField(
                    onChanged: (value) {
                      Momentum.controller<ViewBoundOrganisationController>(
                              context)
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
                  height: 20,
                ),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: TextField(
                    onChanged: (value) {
                      Momentum.controller<ViewBoundOrganisationController>(
                              context)
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
                  height: 20,
                ),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: TextFormField(
                    // validator: () {},
                    onChanged: (value) {
                      Momentum.controller<ViewBoundOrganisationController>(
                              context)
                          .inputAdminConfirmPassword(value);
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
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Momentum.controller<ViewBoundOrganisationController>(
                              context)
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
        return Form(
          key: _formKey,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  pageChildren(constraints.biggest.width / 2, context, true)),
        );
      } else {
        return Form(
          key: _formKey,
          child: Column(
              children:
                  pageChildren(constraints.biggest.width, context, false)),
        );
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