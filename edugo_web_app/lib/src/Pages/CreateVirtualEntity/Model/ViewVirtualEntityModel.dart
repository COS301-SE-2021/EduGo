import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewVirtualEntityModel
    extends MomentumModel<ViewVirtualEntityController> {
  final String name;
  final String description;

  ViewVirtualEntityModel(
    ViewVirtualEntityController controller, {
    this.name,
    this.description,
  }) : super(controller);

  void setViewVirtualEntityName(String name) {
    update(name: name);
  }

  void setViewVirtualEntityDescription(String description) {
    update(description: description);
  }

  @override
  void update({
    createVirtualEntity3dModelLink,
    name,
    description,
  }) {
    ViewVirtualEntityModel(
      controller,
      name: name ?? this.name,
      description: description ?? this.description,
    ).updateMomentum();
  }
}
