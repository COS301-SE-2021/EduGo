//* Create Virtual Enitity Page
//  Todo : Create a virtual entity by giving it a name,description and a 3D Model

import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Components/CreateVirtualEntityComponents.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateVirtualEntityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: PageLayout(
        top: 0,
        left: 150,
        right: 150,
        child:
            //* Content Container
            ListView(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          children: [
            //* Title Row
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Create Virtual Entity",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
                SizedBox(
                  height: 120,
                )
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    DesktopLeftContainer(),
                    SizedBox(
                      width: ScreenUtil().setWidth(270),
                    ),
                    DesktopRightContainer(),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                QuizBuilder(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
