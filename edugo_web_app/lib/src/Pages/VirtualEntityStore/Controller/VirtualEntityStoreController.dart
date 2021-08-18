import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntityStore/Model/Data/VirtualEntities.dart';

class VirtualEntityStoreController
    extends MomentumController<VirtualEntityStoreModel> {
  @override
  VirtualEntityStoreModel init() {
    return VirtualEntityStoreModel(this,
        virtualEntities: [], virtualEntityCards: [], public: false);
  }

  void changePublic(bool public) {
    model.changePublic(public);
  }

// Info: Get all subjects created by the educator
  Future<void> getEducatorVirtualEntityStore(context) async {
    var url = Uri.parse(
        'http://34.65.226.152:8080/virtualEntity/getPrivateVirtualEntities');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
    ).then((response) {
      if (response.statusCode == 200) {
        dynamic _virtualEntities = jsonDecode(response.body);
        model.updateVirtualEntities(
            VirtualEntities.fromJson(_virtualEntities).virtualEntities);
        model.updateVirtualEntityCards();
        return;
      }
    });
  }
}
