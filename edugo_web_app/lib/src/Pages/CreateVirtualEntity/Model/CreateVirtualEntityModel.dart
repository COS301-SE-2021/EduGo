import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateVirtualEntityModel
    extends MomentumModel<CreateVirtualEntityController> {
  final String name;
  final String description;

  CreateVirtualEntityModel(
    CreateVirtualEntityController controller, {
    this.name,
    this.description,
  }) : super(controller);

  void setCreateVirtualEntityName(String name) {
    update(name: name);
  }

  void setCreateVirtualEntityDescription(String description) {
    update(description: description);
  }

  String getCreateVirtualEntityName() {
    return name;
  }

  String getCreateVirtualEntityDescription() {
    return description;
  }

  @override
  void update({
    createVirtualEntity3dModelLink,
    name,
    description,
  }) {
    CreateVirtualEntityModel(
      controller,
      name: name ?? this.name,
      description: description ?? this.description,
    ).updateMomentum();
  }
}
