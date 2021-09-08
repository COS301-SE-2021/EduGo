import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/CreateVirtualEntityWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class DesktopLeftContainer extends StatelessWidget {
  final GlobalKey<FormState> createEntityparentFormKey;

  const DesktopLeftContainer({Key key, this.createEntityparentFormKey})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CreateVirtualEntityController],
      builder: (context, snapshot) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //* Title Row
              Row(
                children: [
                  Text(
                    "Create ",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    "Virtual Entity",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 97, 211, 87),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Material(
                  elevation: 40,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 25, bottom: 5, right: 20, left: 20),
                    child: VirtualEntityInputBox(
                      createEntityKey: createEntityparentFormKey,
                      text: "Entity Name...",
                      onChanged:
                          Momentum.controller<CreateVirtualEntityController>(
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
                    createEntityMultiLineFormKey: createEntityparentFormKey,
                    text: "Entity description...",
                    onChanged:
                        Momentum.controller<CreateVirtualEntityController>(
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
