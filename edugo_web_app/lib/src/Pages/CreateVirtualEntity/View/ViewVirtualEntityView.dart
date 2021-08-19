import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/CreateVirtualEntityWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewVirtualEntityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Momentum.controller<ViewVirtualEntityController>(context)
        .getVirtualEntity(context);
    return MomentumBuilder(
      controllers: [ViewVirtualEntityController],
      builder: (context, snapshot) {
        var entity = snapshot<ViewVirtualEntityModel>();
        return PageLayout(
          top: 50,
          left: 150,
          right: 150,
          child: Container(
            margin: EdgeInsets.only(top: 0),
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purple,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.purple
                  ],
                  stops: [
                    0.0,
                    0.1,
                    0.9,
                    1.0
                  ], // 10% purple, 80% transparent, 10% purple
                ).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding:
                    EdgeInsets.only(top: 0, left: 40, right: 40, bottom: 70),
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 40,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 70, vertical: 40),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      entity.name,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 97, 211, 87),
                                        fontSize: 34,
                                      ),
                                    ),
                                  ),
                                  ViewVirtualEntityModelViewer(),
                                ],
                              ),
                              Spacer(),
                              SizedBox(
                                width: ScreenUtil().setWidth(300),
                                child: Text(
                                  entity.description,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              QrImage(
                                data: 'EduGo_Marker {"ve_id":' +
                                    entity.virtualEntityId +
                                    '}',
                                version: QrVersions.auto,
                                size: 250.0,
                              ),
                              Spacer(),
                              VirtualEntityButton(
                                  child: Text(
                                    "Print Marker",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    final image = await QrPainter(
                                      data: 'EduGo_Marker {"ve_id":' +
                                          entity.virtualEntityId +
                                          '}',
                                      version: QrVersions.auto,
                                      errorCorrectionLevel:
                                          QrErrorCorrectLevel.Q,
                                    ).toImageData(400);

                                    var pngBytes = image.buffer.asUint8List();
                                    var download = document.createElement('a')
                                        as AnchorElement;

                                    download.href = 'data:image/png;base64,' +
                                        base64Encode(pngBytes);
                                    download.download =
                                        entity.name + '_EduGo_3D_Model.png';

                                    download.click();

                                    download.remove();
                                  },
                                  width: 300,
                                  height: 65),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
