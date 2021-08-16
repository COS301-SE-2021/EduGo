import 'package:edugo_web_app/src/Pages/EduGo.dart';

class SignInContent extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  List<Widget> pageChildren(double width, context, bool spacer) {
    return <Widget>[
      SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0, bottom: 100.0),
          child: Material(
            elevation: 40,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 600,
              padding: EdgeInsets.only(top: 100),
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
                                  color: Color.fromARGB(255, 97, 211, 87),
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
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
                          return 'User name cannot be blank';
                        }
                        return "Invalid user name";
                      },
                      onChanged: (value) {
                        Momentum.controller<SessionController>(context)
                            .setLoginUserName(value);
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password cannot be blank';
                        }
                        return "Invalid password";
                      },
                      onChanged: (value) {
                        Momentum.controller<SessionController>(context)
                            .setLoginPassword(value);
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
                    height: 40,
                  ),
                  VirtualEntityButton(
                      elevation: 40,
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (Momentum.controller<SessionController>(context)
                                    .getLoginuserName() ==
                                null ||
                            Momentum.controller<SessionController>(context)
                                    .getLoginPassword() ==
                                null) _formKey.currentState.validate();
                        Momentum.controller<SessionController>(context)
                            .loginUser(context: context, formkey: _formKey);
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
