import 'package:edugo_web_app/src/Pages/CreateLesson/View/Components/CreateLessonComponents.dart';
import 'package:edugo_web_app/src/Pages/CreateLesson/View/Widgets/CreateLessonWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateLessonView extends StatelessWidget {
  const CreateLessonView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      top: 0,
      left: 100,
      right: 100,
      child: ListView(
        padding: EdgeInsets.only(top: 50, bottom: 100, left: 40, right: 40),
        children: [
          Column(
            children: [
              //* Title Row
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Create Lesson",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CreateLessonContainer(),
              SizedBox(
                height: 40,
              ),
              CreateLessonButton(
                  elevation: 40,
                  child: Text(
                    "Create Lesson",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Momentum.controller<CreateLessonController>(context)
                        .createLesson(context);
                  },
                  width: ScreenUtil().setWidth(500),
                  height: 65),
            ],
          )
        ],
      ),
    );
  }
}
