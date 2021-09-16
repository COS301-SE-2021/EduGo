// ignore: avoid_web_libraries_in_flutter
import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'dart:ui' as ui;

class CanvasView extends StatelessWidget {
  const CanvasView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CanvasController],
      builder: (context, snapshot) {
        var canvas = snapshot<CanvasModel>();

        // ignore: undefined_prefixed_name
        ui.platformViewRegistry.registerViewFactory(
            'test-view-type',
            (int viewId) => IFrameElement()
              ..width = '640'
              ..height = '200'
              ..src =
                  "http://edugo-backend.southafricanorth.cloudapp.azure.com:8082/?model=" +
                      "2" +
                      "&token=" +
                      canvas.token
              ..style.border = 'none');

        return PageLayout(
          top: 0,
          left: 0,
          right: 0,
          child: HtmlElementView(viewType: 'test-view-type'),
        );
      },
    );
  }
}
