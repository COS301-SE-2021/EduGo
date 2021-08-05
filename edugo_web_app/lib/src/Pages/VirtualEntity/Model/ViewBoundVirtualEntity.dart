import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewBoundVirtualEntity
    extends MomentumModel<ViewBoundVirtualEntityController> {
  final String name;
  final String description;
  final String id;
  final String viewBoundVirtualEntity3dModelLink;
  ViewBoundVirtualEntity(
    ViewBoundVirtualEntityController controller, {
    this.viewBoundVirtualEntity3dModelLink,
    this.name,
    this.description,
    this.id,
  }) : super(controller);

  void setViewBoundVirtualEntityName(String name) {
    update(name: name);
  }

  void setViewBoundVirtualEntityId(String id) {
    update(id: id);
  }

  void setViewBoundVirtualEntityDescription(String description) {
    update(description: description);
  }

  void setViewBoundVirtualEntity3dModelLink(
      String viewBoundVirtualEntity3dModelLink) {
    update(
        viewBoundVirtualEntity3dModelLink: viewBoundVirtualEntity3dModelLink);
  }

  String getViewBoundVirtualEntityName() {
    return name;
  }

  String getViewBoundVirtualEntityId() {
    return id;
  }

  String getViewBoundVirtualEntityDescription() {
    return description;
  }

  String getViewBoundVirtualEntity3dModelLink() {
    return viewBoundVirtualEntity3dModelLink;
  }

  @override
  void update({viewBoundVirtualEntity3dModelLink, name, description, id}) {
    ViewBoundVirtualEntity(
      controller,
      viewBoundVirtualEntity3dModelLink: viewBoundVirtualEntity3dModelLink ??
          this.viewBoundVirtualEntity3dModelLink,
      name: name ?? this.name,
      id: name ?? this.id,
      description: description ?? this.description,
    ).updateMomentum();
  }
}
