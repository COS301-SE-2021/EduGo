import 'package:edugo_web_app/src/Pages/CreateSubject/View/Widgets/CreateSubjectWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateSubjectDesktopRightContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CreateLessonController],
      builder: (context, snapshot) {
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
              CreateSubjectButton(
                onPressed: () {
                  Momentum.controller<CreateSubjectController>(context)
                      .startWebFilePicker();
                },
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
