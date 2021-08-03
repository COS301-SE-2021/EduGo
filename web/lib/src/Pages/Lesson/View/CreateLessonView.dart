import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateLessonView extends StatelessWidget {
  const CreateLessonView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [],
        builder: (context, snapshot) {
          return PageLayout();
        });
  }
}
