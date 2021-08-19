import 'package:edugo_web_app/src/Pages/EduGo.dart';

class LessonsView extends StatelessWidget {
  const LessonsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [],
        builder: (context, snapshot) {
          return PageLayout();
        });
  }
}
