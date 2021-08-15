import 'package:edugo_web_app/src/Pages/EduGo.dart';

class VirtualEntityApiModel extends MomentumModel<VirtualEntityApiController> {
  VirtualEntityApiModel(
    VirtualEntityApiController controller,
  ) : super(controller);

  @override
  void update() {
    VirtualEntityApiModel(
      controller,
    ).updateMomentum();
  }

  void setViewBoundVirtualEntityName({String virtualEntityName}) {}

  void setViewBoundVirtualEntityDescription(
      {String virtualEntityDescription}) {}

  void setViewBoundVirtualEntity3dModelLink(
      {String virtualEntity3dModelLink}) {}

  String getViewBoundVirtualEntityName() {}

  String getViewBoundVirtualEntityDescription() {}

  String getViewBoundVirtualEntity3dModelLink() {}
}
