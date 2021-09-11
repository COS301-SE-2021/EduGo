import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/Model/Data/ArModel.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateVirtualEntityModel
    extends MomentumModel<CreateVirtualEntityController> {
  final String name;
  final String description;
  final String modelLink;
  final ArModel arModel;
  final bool loadingModelLink;
  final bool creatingEntityLoader;
  final String createEntityResponse;

  CreateVirtualEntityModel(CreateVirtualEntityController controller,
      {this.name,
      this.description,
      this.loadingModelLink,
      this.modelLink,
      this.arModel,
      this.createEntityResponse,
      this.creatingEntityLoader})
      : super(controller);

  void setCreateVirtualEntityName(String inName) {
    update(name: inName);
  }

  void setCreateVirtualEntityDescription(String inDescription) {
    update(description: inDescription);
  }

  void setCreateVirtualEntityModelLink(String inModelLink) {
    update(modelLink: inModelLink);
  }

  void setFileSize(int size) {
    ArModel modelClone = arModel;
    modelClone.setFileSize(size);
    update(arModel: modelClone);
  }

  void setFileType(String type) {
    ArModel modelClone = arModel;
    modelClone.setFileType(type);
    update(arModel: modelClone);
  }

  void setFileName(String name) {
    ArModel modelClone = arModel;
    modelClone.setFileName(name);
    update(arModel: modelClone);
  }

  void clearLinkTo3DModel() {
    update(modelLink: "");
  }

  String getCreateVirtualEntityName() {
    return name;
  }

  String getCreateVirtualEntityDescription() {
    return description;
  }

  @override
  void update(
      {modelLink,
      name,
      description,
      arModel,
      loadingModelLink,
      createEntityResponse,
      creatingEntityLoader}) {
    CreateVirtualEntityModel(
      controller,
      name: name ?? this.name,
      modelLink: modelLink ?? this.modelLink,
      description: description ?? this.description,
      arModel: arModel ?? this.arModel,
      loadingModelLink: loadingModelLink ?? this.loadingModelLink,
      createEntityResponse: createEntityResponse ?? this.createEntityResponse,
      creatingEntityLoader: creatingEntityLoader ?? this.creatingEntityLoader,
    ).updateMomentum();
  }
}
