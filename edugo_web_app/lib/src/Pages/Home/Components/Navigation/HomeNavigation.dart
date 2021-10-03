import 'package:edugo_web_app/src/Pages/EduGo.dart';

class HomeNavigation extends StatelessWidget {
  HomeNavigation() : super(key: Key("HomeNavigation"));
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
      child: Container(
        child: Row(
          children: <Widget>[
            Flexible(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      "Edu",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 45),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Go",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 45),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(450),
              child: Row(
                children: <Widget>[
                  RegisterButton(),
                  Spacer(),
                  SignInButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  SignInButton() : super(key: Key("SignInButton"));

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 150,
      height: 50,
      onPressed: () {
        MomentumRouter.goto(context, LogInView);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          "Sign In",
          style: TextStyle(color: Color.fromARGB(255, 97, 211, 87)),
        ),
      ),
      hoverColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        side: BorderSide(color: Colors.white),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  RegisterButton() : super(key: Key("RegisterButton"));

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 150,
      height: 50,
      onPressed: () {
        MomentumRouter.goto(context, CreateOrganisationView);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          "Register Organisation",
          style: TextStyle(color: Color.fromARGB(255, 97, 211, 87)),
        ),
      ),
      hoverColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        side: BorderSide(color: Colors.white),
      ),
    );
  }
}
