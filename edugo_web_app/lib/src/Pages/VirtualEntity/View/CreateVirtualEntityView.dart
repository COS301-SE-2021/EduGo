//* Create Virtual Enitity Page
//  Todo : Create a virtual entity by giving it a name,description and a 3D Model

import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateVirtualEntityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [VirtualEntityController],
      builder: (context, snapshot) {
        return FocusWatcher(
          child: PageLayout(
            child: Stack(children: [
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
                        DesktopLeftContainer(),
                        SizedBox(
                          width: ScreenUtil().setWidth(270),
                        ),
                        DesktopRightContainer(),
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
