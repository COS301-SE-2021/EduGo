import 'package:edugo_web_app/src/Pages/EduGo.dart';

class HomeDesktopNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Edu",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 45),
                ),
                Text(
                  "Go",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 45),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text("About Us", style: TextStyle(color: Colors.white)),
                SizedBox(
                  width: 30,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      MomentumRouter.goto(context, CreateOrganisationView);
                    },
                    child: Text("Register Organisation",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                MaterialButton(
                  key: Key("SignInButton"),
                  minWidth: 150,
                  height: 40,
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
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
