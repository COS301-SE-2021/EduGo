import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewVirtualEntityController
    extends MomentumController<ViewVirtualEntityModel> {
  @override
  ViewVirtualEntityModel init() {
    return ViewVirtualEntityModel(
      this,
    );
  }

  void viewEntity(
      String name, String description, String id, bool public, context) {
    model.setViewVirtualEntityName(name);
    model.setViewVirtualEntityDescription(description);
    model.setVirtualEntityId(id);
    model.setVirtualEntityBool(public);
    Momentum.controller<ViewVirtualEntityController>(context)
        .getVirtualEntity(context);
  }

  Future<void> getVirtualEntity(context) async {
    var url = Uri.parse(
        EduGoHttpModule().getBaseUrl() + '/virtualEntity/getVirtualEntity');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
      body: jsonEncode(
        <String, int>{"id": int.parse(model.virtualEntityId)},
      ),
    ).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> _virtualEntity = jsonDecode(response.body);
        Map<String, dynamic> _model = _virtualEntity['model'];
        if (_model != null) {
          String modelLink = _model['fileLink'];
          if (modelLink == null)
            return;
          else {
            model.setVirtualEntityModel(modelLink);
            return;
          }
        }
        return;
      }
    });
  }

  // Info: Make entity publicly visible
  Future<void> makePublic(
    context,
  ) async {
    var url = Uri.parse(
        EduGoHttpModule().getBaseUrl() + '/virtualEntity/togglePublic');
    await post(
      url,
      body: jsonEncode(
        <String, int>{"id": int.parse(model.virtualEntityId)},
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
    ).then((response) {
      if (response.statusCode == 200) {
        model.update(public: !model.public);
        return;
      }
    });
  }
}
