import 'package:edugo_web_app/src/Pages/CreateLesson/View/Widgets/CreateLessonWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateLessonContainer extends StatefulWidget {
  final GlobalKey<FormState> createLessonParentKey;
  final Function containerOnSubmit;

  const CreateLessonContainer(
      {Key key, this.createLessonParentKey, this.containerOnSubmit})
      : super(key: key);

  @override
  _CreateLessonContainerState createState() => _CreateLessonContainerState();
}

class _CreateLessonContainerState extends State<CreateLessonContainer> {
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
                padding:
                    EdgeInsets.only(top: 25, bottom: 5, right: 20, left: 20),
                child: CreateLessonInputBox(
                  text: "Lesson title...",
                  createLessonKey: widget.createLessonParentKey,
                  onSubmit: () {
                    widget.containerOnSubmit();
                  },
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
                  createLessonKey: widget.createLessonParentKey,
                  onSubmit: () {
                    widget.containerOnSubmit();
                  },
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
