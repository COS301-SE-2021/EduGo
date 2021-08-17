import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateVirtualEntityModel
    extends MomentumModel<CreateVirtualEntityController> {
  final String name;
  final String description;
  final String viewBoundVirtualEntity3dModelLink;
  CreateVirtualEntityModel(
    CreateVirtualEntityController controller, {
    this.viewBoundVirtualEntity3dModelLink,
    this.name,
    this.description,
  }) : super(controller);

  void setCreateVirtualEntityName(String name) {
    update(name: name);
  }

  void setCreateVirtualEntityDescription(String description) {
    update(description: description);
  }

  void setCreateVirtualEntity3dModelLink(
      String viewBoundVirtualEntity3dModelLink) {
    update(
        viewBoundVirtualEntity3dModelLink: viewBoundVirtualEntity3dModelLink);
  }

  String getCreateVirtualEntityName() {
    return name;
  }

  String getCreateVirtualEntityDescription() {
    return description;
  }

  String getCreateVirtualEntity3dModelLink() {
    return viewBoundVirtualEntity3dModelLink;
  }

  @override
  void update({
    viewBoundVirtualEntity3dModelLink,
    name,
    description,
  }) {
    CreateVirtualEntityModel(
      controller,
      viewBoundVirtualEntity3dModelLink: viewBoundVirtualEntity3dModelLink ??
          this.viewBoundVirtualEntity3dModelLink,
      name: name ?? this.name,
      description: description ?? this.description,
    ).updateMomentum();
  }
}
