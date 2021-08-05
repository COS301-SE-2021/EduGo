import 'package:edugo_web_app/src/Pages/EduGo.dart';

class QuizBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [VirtualEntityApiController],
      builder: (context, snapshot) {
        var entity = snapshot<VirtualEntityApiModel>();
        return Container(
          width: ScreenUtil().setWidth(230),
          child: Text(""),
        );
      },
    );
  }
}
