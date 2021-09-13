import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Login/View/Widgets/LogInWidgets.dart';

class LogInContent extends StatelessWidget {
  LogInContent() : super(key: Key("LogInContent"));
  final _formKey = GlobalKey<FormState>();
  List<Widget> pageChildren(double width, context, bool spacer) {
    return <Widget>[
      MomentumBuilder(
        controllers: [LogInController],
        builder: (context, snapshot) {
          Momentum.controller<LogInController>(context).resetErrorString();
          var errorStringFetch = snapshot<LoginModel>();

          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
              child: Material(
                elevation: 40,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: ScreenUtil().setWidth(600),
                  height: ScreenUtil().setHeight(900),
                  padding: EdgeInsets.only(
                    top: 100,
                  ),
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
                        height: 60,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(450),
                        height: 100,
                        child: TextFormField(
                          key: Key("LogInUserName"),
                          onFieldSubmitted: (value) {
                            Momentum.controller<LogInController>(context)
                                .loginUser(context: context, formkey: _formKey);
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
                        width: ScreenUtil().setWidth(450),
                        height: 100,
                        child: TextFormField(
                          key: Key("LogInPassword"),
                          onFieldSubmitted: (value) {
                            Momentum.controller<LogInController>(context)
                                .loginUser(context: context, formkey: _formKey);
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
                          onPressed: () {
                            Momentum.controller<LogInController>(context)
                                .loginUser(context: context, formkey: _formKey);
                          },
                          width: ScreenUtil().setWidth(430),
                          height: 65),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
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
