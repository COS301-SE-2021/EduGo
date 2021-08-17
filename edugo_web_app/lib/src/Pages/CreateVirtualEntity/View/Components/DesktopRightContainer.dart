import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/CreateVirtualEntityWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class DesktopRightContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CreateVirtualEntityController],
      builder: (context, snapshot) {
        var entity = snapshot<CreateVirtualEntityModel>();
        return Container(
          width: ScreenUtil().setWidth(230),
          child: ('${entity.viewBoundVirtualEntity3dModelLink}' == "null")
              ? Center(
                  child: VirtualEntityButton(
                      elevation: 40,
                      child: Text(
                        "Upload 3D Model",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Momentum.controller<CreateVirtualEntityController>(
                                context)
                            .upload3dModel(context);
                      },
                      width: ScreenUtil().setWidth(400),
                      height: 60),
                )
              : Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: VirtualEntityButton(
                          child: Text(
                            "Discard 3D Model",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Momentum.controller<CreateVirtualEntityController>(
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
      },
    );
  }
}
