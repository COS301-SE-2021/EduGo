// * Navigation builder for the web app

import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'DesktopNavBar.dart';
import 'TabletNavBar.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return DesktopNavBar();
      } else
        return TabletNavBar();
    });
  }
}
