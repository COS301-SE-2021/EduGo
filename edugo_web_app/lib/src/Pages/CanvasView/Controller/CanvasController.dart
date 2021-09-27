import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CanvasController extends MomentumController<CanvasModel> {
  @override
  CanvasModel init() {
    return CanvasModel(
      this,
    );
  }

  void getCanvasView(context, id) async {
    model.update(
        token: Momentum.controller<AdminController>(context)
            .getToken()
            .split(" ")[1]);
    model.update(entityId: id);
    MomentumRouter.goto(context, CanvasView);
  }
}
