import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateSubjectDesktopRightContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [VirtualEntityController],
        builder: (context, snapshot) {
          var entity = snapshot<VirtualEntityModel>();
          return Container(
            width: ScreenUtil().setWidth(230),
            child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.add_a_photo_outlined,
                              size: 100,
                              color: Color.fromARGB(255, 97, 211, 87),
                            ),
                            SizedBox(height: 70),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              onPressed: () {},
                              minWidth: 20,
                              height: 50,
                              color: Color.fromARGB(255, 97, 211, 87),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.add_outlined,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Add Photo",
                                    
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
          );
        });
  }
}
