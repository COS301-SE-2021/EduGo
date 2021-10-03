import 'package:edugo_web_app/src/Pages/EduGo.dart';

class EducatorsEmailInputCard extends StatefulWidget {
  static var _controller = TextEditingController();

  const EducatorsEmailInputCard({
    Key key,
  }) : super(key: key);

  @override
  _EducatorsEmailInputCardState createState() =>
      _EducatorsEmailInputCardState();
}

class _EducatorsEmailInputCardState extends State<EducatorsEmailInputCard> {
  final _educatorFormKey = GlobalKey<FormState>();

  final RegExp regex = new RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [InviteEducatorsController],
      builder: (context, snapshot) {
        return Form(
          key: _educatorFormKey,
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Material(
              elevation: 40,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: ScreenUtil().setWidth(1200),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        width: ScreenUtil().setWidth(800),
                        height: 75,
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Educator email cannot be blank';
                            }

                            if (!regex.hasMatch(value) || value == null)
                              return 'Enter a valid email address';
                            return null;
                          },
                          controller: EducatorsEmailInputCard._controller,
                          onChanged: (value) {
                            if (_educatorFormKey.currentState.validate())
                              Momentum.controller<InviteEducatorsController>(
                                      context)
                                  .inputEmail(value);
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
                              hintText: "Enter email..."),
                          onFieldSubmitted: (value) {
                            if (_educatorFormKey.currentState.validate()) {
                              Momentum.controller<InviteEducatorsController>(
                                      context)
                                  .addEmail();
                              EducatorsEmailInputCard._controller.clear();
                            }
                          },
                        ),
                      ),
                    ),
                    Spacer(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Icon(Icons.add,
                            size: 40, color: Color.fromARGB(255, 97, 211, 87)),
                        onTap: () {
                          if (_educatorFormKey.currentState.validate()) {
                            Momentum.controller<InviteEducatorsController>(
                                    context)
                                .addEmail();
                            EducatorsEmailInputCard._controller.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
