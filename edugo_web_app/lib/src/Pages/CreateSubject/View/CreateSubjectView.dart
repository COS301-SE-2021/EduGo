import 'package:edugo_web_app/src/Pages/CreateSubject/View/Components/CreateSubjectComponents.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateSubjectView extends StatelessWidget {
  const CreateSubjectView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      top: 50,
      left: 150,
      right: 150,
      child: Stack(
        children: [
          //* Title Row
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Create Subject",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(100),
              )
            ],
          ),
          //* Content Container
          Container(
            padding: EdgeInsets.only(top: 75),
            child: ListView(
              padding: EdgeInsets.only(bottom: 30),
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(200),
                    ),
                    CreateSubjectDesktopLeftContainer(),
                    SizedBox(
                      width: ScreenUtil().setWidth(270),
                    ),
                    CreateSubjectDesktopRightContainer(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
