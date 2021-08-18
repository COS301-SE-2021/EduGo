import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewVirtualEntityModel
    extends MomentumModel<ViewVirtualEntityController> {
  final String name;
  final String description;
  final String virtualEntityId;
  final String modelLink;

  ViewVirtualEntityModel(
    ViewVirtualEntityController controller, {
    this.name,
    this.virtualEntityId,
    this.description,
    this.modelLink,
  }) : super(controller);

  void setViewVirtualEntityName(String name) {
    update(name: name);
  }

  void setViewVirtualEntityDescription(String description) {
    update(description: description);
  }

  void setVirtualEntityId(String id) {
    update(virtualEntityId: id);
  }

  void setVirtualEntityModel(String link) {
    update(modelLink: link);
  }

  @override
  void update(
      {createVirtualEntity3dModelLink,
      name,
      description,
      virtualEntityId,
      modelLink}) {
    ViewVirtualEntityModel(
      controller,
      modelLink: modelLink ?? this.modelLink,
      virtualEntityId: virtualEntityId ?? this.virtualEntityId,
      name: name ?? this.name,
      description: description ?? this.description,
    ).updateMomentum();
  }
}
