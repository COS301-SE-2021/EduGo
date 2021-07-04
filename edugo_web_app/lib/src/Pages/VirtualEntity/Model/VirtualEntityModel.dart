import 'package:edugo_web_app/src/Controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:momentum/momentum.dart';

class VirtualEntityModel extends MomentumModel<VirtualEntityController> {
  final int value;
  final String virtualEntityName;
  final List<Widget> virtualEntityStore;
  VirtualEntityModel(VirtualEntityController controller,
      {this.value, this.virtualEntityName, this.virtualEntityStore})
      : super(controller);

  @override
  void update({
    int value,
  }) {
    VirtualEntityModel(
      controller,
      value: value ?? this.value,
    ).updateMomentum();
  }

  void updateVirtualEntityName({String virtualEntityName}) {
    VirtualEntityModel(controller,
            virtualEntityName: virtualEntityName ?? this.virtualEntityName)
        .updateMomentum();
  }

  void updateVirtualEntityStore({List<Widget> virtualEntities}) {
    VirtualEntityModel(controller,
            virtualEntityName: virtualEntityName,
            virtualEntityStore: virtualEntities ?? this.virtualEntityStore)
        .updateMomentum();
  }
}
