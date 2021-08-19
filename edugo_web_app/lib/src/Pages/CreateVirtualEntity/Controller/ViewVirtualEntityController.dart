import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewVirtualEntityController
    extends MomentumController<ViewVirtualEntityModel> {
  @override
  ViewVirtualEntityModel init() {
    return ViewVirtualEntityModel(
      this,
    );
  }

  void viewEntity(String name, String description, String id) {
    model.setViewVirtualEntityName(name);
    model.setViewVirtualEntityDescription(description);
    model.setVirtualEntityId(id);
  }

  String getLink() {
    return model.viewEntityLink;
  }

  Future<void> getVirtualEntity(context) async {
    var url =
        Uri.parse('http://34.65.226.152:8080/virtualEntity/getVirtualEntity');
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
          String modelLink = _model['file_link'];
          if (modelLink == null)
            return;
          else {
            model.setVirtualEntityModel(modelLink);
          }
        }
        return;
      }
    });
  }
}
