import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/CreateVirtualEntityWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewVirtualEntityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [ViewVirtualEntityController],
      builder: (context, snapshot) {
        var entity = snapshot<ViewVirtualEntityModel>();

        Future<String> entityLinkLoaded = Future<String>.delayed(
          const Duration(seconds: 0),
          () {
            if (entity.viewEntityLink.isEmpty) return null;
            return entity.viewEntityLink;
          },
        );

        return PageLayout(
          top: 0,
          left: 70,
          right: 70,
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
                    EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 80),
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 40,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 70, vertical: 50),
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
                                        fontSize: 36,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: ScreenUtil().setWidth(400),
                                    height: 500,
                                    child: FutureBuilder(
                                      future: entityLinkLoaded,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        if (snapshot.hasData)
                                          return ViewVirtualEntityModelViewer();
                                        return Scaffold(
                                          body: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 100,
                                                  width: 100,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        new AlwaysStoppedAnimation<
                                                                Color>(
                                                            Color.fromARGB(255,
                                                                97, 211, 87)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Rendering ",
                                                      style: TextStyle(
                                                          fontSize: 28),
                                                    ),
                                                    Text(
                                                      "3D mo",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 97, 211, 87),
                                                          fontSize: 28),
                                                    ),
                                                    Text(
                                                      "del...",
                                                      style: TextStyle(
                                                          fontSize: 28),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 40,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 70, vertical: 40),
                                  child: Column(
                                    children: [
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: SlidingSwitch(
                                          value: entity.public,
                                          width: 250,
                                          onChanged: (bool value) {
                                            Momentum.controller<
                                                        ViewVirtualEntityController>(
                                                    context)
                                                .makePublic(context);
                                          },
                                          height: 55,
                                          animationDuration:
                                              const Duration(milliseconds: 400),
                                          onTap: () {},
                                          textOff: "Private",
                                          textOn: "Public",
                                          colorOn:
                                              Color.fromARGB(255, 97, 211, 87),
                                          colorOff:
                                              Color.fromARGB(255, 97, 211, 87),
                                          background: const Color(0xffe4e5eb),
                                          buttonColor: const Color(0xfff7f5f7),
                                          inactiveColor:
                                              const Color(0xff636f7b),
                                        ),
                                      ),
                                      SizedBox(height: 50),
                                      Text(
                                        "Description:",
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 97, 211, 87),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(300),
                                        child: Text(
                                          entity.description,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
