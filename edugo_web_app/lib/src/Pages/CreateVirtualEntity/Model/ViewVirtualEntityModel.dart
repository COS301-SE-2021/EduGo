import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewVirtualEntityModel
    extends MomentumModel<ViewVirtualEntityController> {
  final String name;
  final String description;
  final String virtualEntityId;
  final String viewEntityLink;

  ViewVirtualEntityModel(
    ViewVirtualEntityController controller, {
    this.name,
    this.virtualEntityId,
    this.description,
    this.viewEntityLink,
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
    update(viewEntityLink: link);
  }

  @override
  void update({name, description, virtualEntityId, viewEntityLink}) {
    ViewVirtualEntityModel(
      controller,
      virtualEntityId: virtualEntityId ?? this.virtualEntityId,
      name: name ?? this.name,
      description: description ?? this.description,
      viewEntityLink: viewEntityLink ?? this.viewEntityLink,
    ).updateMomentum();
  }
}
