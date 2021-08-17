import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/CreateVirtualEntityWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewVirtualEntityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Momentum.controller<>(context).preview3DModel();
    return MomentumBuilder(
      controllers: [AdminController],
      builder: (context, snapshot) {
        var entity = snapshot<AdminModel>();
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'name',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 97, 211, 87),
                                    fontSize: 34,
                                  ),
                                ),
                              ),
                              Viewer(),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              SizedBox(
                                width: ScreenUtil().setWidth(300),
                                child: Text(
                                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose.",
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              VirtualEntityButton(
                                  child: Text("Add Entity to Lesson"),
                                  onPressed: () {
                                    MomentumRouter.goto(context, LessonsView);
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
