import 'package:edugo_web_app/src/Pages/EduGo.dart';

class DesktopLeftContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [VirtualEntityApiController],
      builder: (context, snapshot) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                  elevation: 40,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: VirtualEntityInputBox(
                      text: "Entity Name...",
                      onChanged:
                          Momentum.controller<ViewBoundVirtualEntityController>(
                              context).,
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Material(
                elevation: 40,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: VirtualEntityMultiLine(
                    text: "Entity description...",
                  ),
                ),
              ),
              // SizedBox(
              //   height: 40,
              // ),
              // VirtualEntityButton(
              //     elevation: 40,
              //     child: Text(
              //       "Create Virtual Entity",
              //       style: TextStyle(color: Colors.white),
              //     ),
              //     onPressed: () {
              //       MomentumRouter.goto(context, EducatorVirtualEntitiesView);
              //     },
              //     width: 450,
              //     height: 65),
            ],
          ),
        );
      },
    );
  }
}
