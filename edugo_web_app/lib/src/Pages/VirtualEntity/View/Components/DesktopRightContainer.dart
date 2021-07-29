import 'package:edugo_web_app/src/Pages/EduGo.dart';

class DesktopRightContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [VirtualEntityController],
        builder: (context, snapshot) {
          var entity = snapshot<VirtualEntityModel>();
          return Container(
            width: ScreenUtil().setWidth(230),
            child: ('${entity.virtualEntity3DModelLink}' == "")
                ? Center(
                    child: VirtualEntityButton(
                        elevation: 40,
                        child: Text("Upload 3D Model"),
                        onPressed: () {
                          Momentum.controller<VirtualEntityController>(context)
                              .upload3DModel();
                        },
                        width: ScreenUtil().setWidth(400),
                        height: 60),
                  )
                : Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: VirtualEntityButton(
                            child: Text("Discard 3D Model"),
                            onPressed: () {
                              Momentum.controller<VirtualEntityController>(
                                      context)
                                  .clearLinkTo3DModel();
                            },
                            width: ScreenUtil().setWidth(200),
                            height: 50),
                      ),
                      Viewer(),
                    ],
                  ),
          );
        });
  }
}
