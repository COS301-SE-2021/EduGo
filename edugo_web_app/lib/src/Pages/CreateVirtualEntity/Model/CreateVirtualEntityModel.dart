import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateVirtualEntityModel
    extends MomentumModel<CreateVirtualEntityController> {
  final String name;
  final String description;
  final String modelLink;

  CreateVirtualEntityModel(CreateVirtualEntityController controller,
      {this.name, this.description, this.modelLink})
      : super(controller);

  void setCreateVirtualEntityName(String name) {
    update(name: name);
  }

  void setCreateVirtualEntityDescription(String description) {
    update(description: description);
  }

  void setCreateVirtualEntityModelLink(String modelLink) {
    update(modelLink: modelLink);
  }

  String getCreateVirtualEntityName() {
    return name;
  }

  String getCreateVirtualEntityDescription() {
    return description;
  }

  @override
  void update({
    modelLink,
    name,
    description,
  }) {
    CreateVirtualEntityModel(
      controller,
      name: name ?? this.name,
      modelLink: modelLink ?? this.modelLink,
      description: description ?? this.description,
    ).updateMomentum();
  }
}
