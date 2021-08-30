import 'package:edugo_web_app/src/Pages/CreateLesson/View/Widgets/CreateLessonWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateLessonContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CreateLessonController],
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Material(
              elevation: 40,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: CreateLessonInputBox(
                  text: "Lesson title...",
                  onChanged: (lessonTitle) {
                    Momentum.controller<CreateLessonController>(context)
                        .setLessonTitle(lessonTitle);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Material(
              elevation: 40,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: CreateLessonMultiLine(
                  text: "Lesson description...",
                  onChanged: (lessonDescription) {
                    Momentum.controller<CreateLessonController>(context)
                        .setLessonDescription(lessonDescription);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
