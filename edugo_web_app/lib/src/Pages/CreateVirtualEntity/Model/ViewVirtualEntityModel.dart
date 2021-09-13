import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewVirtualEntityModel
    extends MomentumModel<ViewVirtualEntityController> {
  final String name;
  final String description;
  final String virtualEntityId;
  final String viewEntityLink;
  final bool public;

  ViewVirtualEntityModel(
    ViewVirtualEntityController controller, {
    this.name,
    this.virtualEntityId,
    this.public,
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

  void setVirtualEntityBool(bool public) {
    update(public: public);
  }

  @override
  void update(
      {String name,
      String description,
      String virtualEntityId,
      String viewEntityLink,
      bool public}) {
    ViewVirtualEntityModel(
      controller,
      virtualEntityId: virtualEntityId ?? this.virtualEntityId,
      public: public ?? this.public,
      name: name ?? this.name,
      description: description ?? this.description,
      viewEntityLink: viewEntityLink ?? this.viewEntityLink,
    ).updateMomentum();
  }
}
