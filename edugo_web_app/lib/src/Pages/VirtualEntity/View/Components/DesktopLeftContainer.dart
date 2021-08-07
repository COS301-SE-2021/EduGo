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
                                  context)
                              .inputName,
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
                    onChanged:
                        Momentum.controller<ViewBoundVirtualEntityController>(
                                context)
                            .inputDescription,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
