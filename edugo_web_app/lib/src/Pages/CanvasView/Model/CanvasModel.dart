import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CanvasModel extends MomentumModel<CanvasController> {
  final String entityId;
  final String token;

  CanvasModel(CanvasController controller, {this.entityId, this.token})
      : super(controller);

  @override
  void update({String entityId, String token}) {
    CanvasModel(controller,
            entityId: entityId ?? this.entityId, token: token ?? this.token)
        .updateMomentum();
  }
}
