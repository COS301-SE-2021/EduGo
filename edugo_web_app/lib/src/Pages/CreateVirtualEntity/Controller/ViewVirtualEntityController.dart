import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewVirtualEntityController
    extends MomentumController<ViewVirtualEntityModel> {
  @override
  ViewVirtualEntityModel init() {
    return ViewVirtualEntityModel(
      this,
    );
  }

  void viewEntity(String name, description) {
    model.setViewVirtualEntityName(name);
    model.setViewVirtualEntityDescription(description);
  }
}
