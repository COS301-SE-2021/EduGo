import 'package:edugo_web_app/src/Components/Components.dart';
import 'package:edugo_web_app/src/Controller.dart';
import 'package:edugo_web_app/src/Model.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class ViewVirtualEntityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [VirtualEntityController],
      builder: (context, snapshot) {
        var entity = snapshot<VirtualEntityModel>();
        return PageLayout(
          child: Stack(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${entity.virtualEntityName}',
                      style: TextStyle(fontSize: 34),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 60),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(left: 20, right: 20),
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
                            Viewer(),
                            Spacer(),
                            Column(
                              children: [
                                SizedBox(
                                  width: 400,
                                  child: Text(
                                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose.",
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                VirtualEntityButton(
                                    text: "Add Entity to Lesson",
                                    onPressed: () {
                                      Momentum.controller<
                                              VirtualEntityController>(context)
                                          .updateVirtualEntityName(
                                              "Noah the Star!!!");
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
            ],
          ),
        );
      },
    );
  }
}
