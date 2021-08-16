import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateLessonDesktopBottomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [LessonController, SubjectController],
      builder: (context, snapshot) {
        return Row(
          children: <Widget>[
            LessonButton(
              onPressed: () {},
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.storefront_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Add Virtual Entity",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              width: ScreenUtil().setWidth(500),
              height: 60,
            ),
            Spacer(),
            LessonButton(
                elevation: 40,
                child: Text(
                  "Create Lesson",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Momentum.controller<LessonController>(context)
                      .createLesson(context);
                },
                width: ScreenUtil().setWidth(500),
                height: 65),
          ],
        );
      },
    );
  }
}

  // LessonButton(
  //                 onPressed: () {},
  //                 child: Row(
  //                   children: <Widget>[
  //                     Icon(
  //                       Icons.add,
  //                       color: Colors.white,
  //                     ),
  //                     SizedBox(width: 20),
  //                     Text(
  //                       "Add Virtual Entity",
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 width: 250,
  //                 height: 60,
  //               ),