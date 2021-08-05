import 'package:edugo_web_app/src/Pages/EduGo.dart';

class VirtualEntityModel extends MomentumModel<VirtualEntityController> {
  final VirtualEntity currentVirtualEntity;
  final VirtualEntity viewBoundVirtualEntity;
  VirtualEntityModel(VirtualEntityController controller,
      {this.currentVirtualEntity, this.viewBoundVirtualEntity})
      : super(controller);

  @override
  void update({
    VirtualEntity viewBoundVirtualEntity,
    VirtualEntity currentVirtualEntity,
  }) {
    VirtualEntityModel(
      controller,
      viewBoundVirtualEntity: currentVirtualEntity ?? this.currentVirtualEntity,
      currentVirtualEntity: currentVirtualEntity ?? this.currentVirtualEntity,
    ).updateMomentum();
  }

  void setViewBoundVirtualEntityName({String virtualEntityName}) {
    VirtualEntity temporaryVirtualEntity = viewBoundVirtualEntity;
    temporaryVirtualEntity.setVirtualEntityName(virtualEntityName);
    update(viewBoundVirtualEntity: temporaryVirtualEntity);
  }

  void setViewBoundVirtualEntityDescription({String virtualEntityDescription}) {
    VirtualEntity temporaryVirtualEntity = viewBoundVirtualEntity;
    temporaryVirtualEntity
        .setVirtualEntityDescription(virtualEntityDescription);
    update(viewBoundVirtualEntity: temporaryVirtualEntity);
  }

  void setViewBoundVirtualEntity3dModelLink({String virtualEntity3dModelLink}) {
    VirtualEntity temporaryVirtualEntity = viewBoundVirtualEntity;
    temporaryVirtualEntity
        .setVirtualEntity3dModelLink(virtualEntity3dModelLink);
    update(viewBoundVirtualEntity: temporaryVirtualEntity);
  }

  String getViewBoundVirtualEntityName() {
    return viewBoundVirtualEntity.getVirtualEntityName();
  }

  String getViewBoundVirtualEntityDescription() {
    return viewBoundVirtualEntity.getVirtualEntityDescription();
  }

  String getViewBoundVirtualEntity3dModelLink() {
    return viewBoundVirtualEntity.getVirtualEntity3dModelLink();
  }
}
