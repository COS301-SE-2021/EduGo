import 'package:edugo_web_app/src/Pages/EduGo.dart';

class UpdateVirtualEntityView extends StatelessWidget {
  UpdateVirtualEntityView();
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [VirtualEntityApiController],
      builder: (context, snapshot) {
        return PageLayout(
          top: 50,
          left: 150,
          right: 150,
          child: Stack(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Mish the skeleton",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topRight,
                    child: VirtualEntityButton(
                        child: Text("Delete Entity"),
                        onPressed: () {},
                        width: 200,
                        height: 50),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 60),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 70, left: 20, right: 20),
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                        elevation: 40,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: VirtualEntityInputBox(
                              text: "Entity Name...",
                            ))),
                    SizedBox(
                      height: 30,
                    ),
                    Material(
                      elevation: 40,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: VirtualEntityMultiLine(
                            text: "Description",
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 40,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 40),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Viewer(),
                              Spacer(),
                              Column(
                                children: [
                                  VirtualEntityButton(
                                      child: Text("Change 3D Model"),
                                      onPressed: () {},
                                      width: 400,
                                      height: 65),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  VirtualEntityButton(
                                      child: Text("Print Marker"),
                                      onPressed: () {},
                                      width: 400,
                                      height: 65)
                                ],
                              )
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    VirtualEntityButton(
                        child: Text("Update Virtual Entity"),
                        onPressed: () {},
                        width: 400,
                        height: 65),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
