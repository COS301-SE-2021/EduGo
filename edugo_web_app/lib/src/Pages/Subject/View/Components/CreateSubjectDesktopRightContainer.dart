import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateSubjectDesktopRightContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [VirtualEntityController],
      builder: (context, snapshot) {
        var entity = snapshot<VirtualEntityModel>();
        return Container(
          width: ScreenUtil().setWidth(230),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.add_a_photo_outlined,
                size: 100,
                color: Color.fromARGB(255, 97, 211, 87),
              ),
              SizedBox(height: 70),
              SubjectButton(
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Add Photo",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                width: 250,
                height: 60,
              ),
            ],
          ),
        );
      },
    );
  }
}
