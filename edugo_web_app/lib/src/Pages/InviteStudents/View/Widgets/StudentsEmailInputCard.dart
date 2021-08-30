import 'package:edugo_web_app/src/Pages/EduGo.dart';

class StudentsEmailInputCard extends StatefulWidget {
  static var _controller = TextEditingController();

  StudentsEmailInputCard({
    Key key,
  }) : super(key: key);

  @override
  _StudentsEmailInputCardState createState() => _StudentsEmailInputCardState();
}

class _StudentsEmailInputCardState extends State<StudentsEmailInputCard> {
  final _studentFormKey = GlobalKey<FormState>();

  final RegExp regex = new RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [InviteStudentsController],
      builder: (context, snapshot) {
        return Form(
          key: _studentFormKey,
          child: Material(
            elevation: 40,
            borderRadius: BorderRadius.circular(10),
            child: Container(
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
                            return 'Student email cannot be blank';
                          }

                          if (!regex.hasMatch(value) || value == null)
                            return 'Enter a valid email address';
                          return null;
                        },
                        controller: StudentsEmailInputCard._controller,
                        onChanged: (value) {
                          if (_studentFormKey.currentState.validate())
                            Momentum.controller<InviteStudentsController>(
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
                            hintText: "Enter student email..."),
                        onFieldSubmitted: (value) {
                          if (_studentFormKey.currentState.validate()) {
                            Momentum.controller<InviteStudentsController>(
                                    context)
                                .addEmail();
                            StudentsEmailInputCard._controller.clear();
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
                        if (_studentFormKey.currentState.validate()) {
                          Momentum.controller<InviteStudentsController>(context)
                              .addEmail();
                          StudentsEmailInputCard._controller.clear();
                        }
                      },
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
