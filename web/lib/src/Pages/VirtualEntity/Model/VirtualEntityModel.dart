import 'package:edugo_web_app/src/Controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:momentum/momentum.dart';

class VirtualEntityModel extends MomentumModel<VirtualEntityController> {
  final String virtualEntityName;
  final String virtualEntity3DModelLink;
  final List<Widget> virtualEntityStore;
  VirtualEntityModel(VirtualEntityController controller,
      {this.virtualEntityName,
      this.virtualEntityStore,
      this.virtualEntity3DModelLink})
      : super(controller);

  @override
  void update({
    String virtualEntityName,
    String virtualEntity3DModelLink,
    List<Widget> virtualEntityStore,
  }) {
    VirtualEntityModel(controller,
            virtualEntityName: virtualEntityName ?? this.virtualEntityName,
            virtualEntity3DModelLink:
                virtualEntity3DModelLink ?? this.virtualEntity3DModelLink,
            virtualEntityStore: virtualEntityStore ?? this.virtualEntityStore)
        .updateMomentum();
  }

  void updateVirtualEntityName({String virtualEntityName}) {
    update(virtualEntityName: virtualEntityName);
  }

  void updateVirtualEntityStore({List<Widget> virtualEntities}) {
    update(virtualEntityStore: virtualEntities);
  }

  void updateVirtualEntity3DModelLink({String virtualEntity3DModelLink}) {
    update(virtualEntity3DModelLink: virtualEntity3DModelLink);
  }
}
