import 'package:edugo_web_app/src/Model.dart';
import 'package:momentum/momentum.dart';

class VirtualEntityController extends MomentumController<VirtualEntityModel> {
  @override
  VirtualEntityModel init() {
    return VirtualEntityModel(
      this,
      value: 0,
    );
  }

  void increment() {
    var value = model.value; // grab the current value
    model.update(value: value + 1); // update state (rebuild widgets)
    print(model.value); // new or updated value
  }

  void updateVirtualEntityName(String virtualEntityName) {
    model.updateVirtualEntityName(virtualEntityName: virtualEntityName);
  }
}
