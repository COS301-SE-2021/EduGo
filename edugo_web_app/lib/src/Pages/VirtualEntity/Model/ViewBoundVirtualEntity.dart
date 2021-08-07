import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewBoundVirtualEntity
    extends MomentumModel<ViewBoundVirtualEntityController> {
  final String name;
  final String description;
  final String viewBoundVirtualEntity3dModelLink;
  ViewBoundVirtualEntity(
    ViewBoundVirtualEntityController controller, {
    this.viewBoundVirtualEntity3dModelLink,
    this.name,
    this.description,
  }) : super(controller);

  void setViewBoundVirtualEntityName(String name) {
    update(name: name);
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

  String getViewBoundVirtualEntityDescription() {
    return description;
  }

  String getViewBoundVirtualEntity3dModelLink() {
    return viewBoundVirtualEntity3dModelLink;
  }

  @override
  void update({
    viewBoundVirtualEntity3dModelLink,
    name,
    description,
  }) {
    ViewBoundVirtualEntity(
      controller,
      viewBoundVirtualEntity3dModelLink: viewBoundVirtualEntity3dModelLink ??
          this.viewBoundVirtualEntity3dModelLink,
      name: name ?? this.name,
      description: description ?? this.description,
    ).updateMomentum();
  }
}
