import 'package:edugo_web_app/ui/Views/subject/SubjectsPage.dart';
import 'package:flutter/material.dart';

class LandingPageNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return DesktopNavbar();
      } else
        return TabletNavbar();
    });
  }
}

class TabletNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Container(
        child: Column(
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("About Us", style: TextStyle(color: Colors.white)),
                  SizedBox(
                    width: 30,
                  ),
                  Text("Register Organisation",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DesktopNavbar extends StatelessWidget {
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
                Text("Register Organisation",
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  width: 30,
                ),
                MaterialButton(
                  minWidth: 150,
                  height: 40,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SubjectsPage()),
                    );
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
