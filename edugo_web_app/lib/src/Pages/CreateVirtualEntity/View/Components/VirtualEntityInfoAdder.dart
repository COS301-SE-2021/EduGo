import 'package:edugo_web_app/src/Pages/EduGo.dart';

class VirtualEntityInfoAdder extends StatefulWidget {
  static var _controller = TextEditingController();
  VirtualEntityInfoAdder({
    Key key,
  }) : super(key: key);

  @override
  _VirtualEntityInfoAdderState createState() => _VirtualEntityInfoAdderState();
}

class _VirtualEntityInfoAdderState extends State<VirtualEntityInfoAdder> {
  final _infoAddFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [CreateVirtualEntityController],
        builder: (context, snapshot) {
          var entity = snapshot<CreateVirtualEntityModel>();
          return Form(
            key: _infoAddFormKey,
            child: SizedBox(
              width: 450,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 400,
                        height: 75,
                        child: TextFormField(
                          controller: VirtualEntityInfoAdder._controller,
                          onChanged: (value) {
                            Momentum.controller<CreateVirtualEntityController>(
                                    context)
                                .inputInfo(infoValue: value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Required field, cannot be blank';
                            }
                            return null;
                          },
                          cursorColor: Color.fromARGB(255, 97, 211, 87),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 97, 211, 87),
                                  width: 2.0),
                            ),
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(fontSize: 20),
                            hintText: "Enter virtual entity information...",
                          ),
                        ),
                      ),
                      Spacer(),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: Icon(Icons.add,
                              size: 40,
                              color: Color.fromARGB(255, 97, 211, 87)),
                          onTap: () {
                            if (_infoAddFormKey.currentState.validate()) {
                              Momentum.controller<
                                      CreateVirtualEntityController>(context)
                                  .inputDescription();
                              VirtualEntityInfoAdder._controller.clear();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(children: entity.informationCards),
                ],
              ),
            ),
          );
        });
  }
}
