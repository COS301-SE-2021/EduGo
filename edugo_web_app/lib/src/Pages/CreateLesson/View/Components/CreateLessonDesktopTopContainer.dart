import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateLessonDesktopTopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [LessonController],
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
                child: LessonInputBox(
                  text: "Lesson title...",
                  onChanged: (lessonTitle) {
                    Momentum.controller<LessonController>(context)
                        .setViewBoundLessonTitle(lessonTitle);
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
                child: LessonMultiLine(
                  text: "Lesson description...",
                  onChanged: (lessonDescription) {
                    Momentum.controller<LessonController>(context)
                        .setViewBoundLessonDescription(lessonDescription);
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
