import 'package:edugo_web_app/src/Controller.dart';

import 'package:momentum/momentum.dart';

class VirtualEntityModel extends MomentumModel<VirtualEntityController> {
  final int value;
  final String virtualEntityName;
  VirtualEntityModel(
    VirtualEntityController controller, {
    this.value,
    this.virtualEntityName,
  }) : super(controller);

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
}
