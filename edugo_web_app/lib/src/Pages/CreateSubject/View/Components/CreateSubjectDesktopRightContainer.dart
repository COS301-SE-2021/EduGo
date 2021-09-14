import 'package:edugo_web_app/src/Pages/CreateSubject/View/Widgets/CreateSubjectWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateSubjectDesktopRightContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CreateSubjectController],
      builder: (context, snapshot) {
        var createSubject = snapshot<CreateSubjectModel>();
        return Container(
          width: ScreenUtil().setWidth(230),
          child: Column(
            children: '${createSubject.subjectImage}' == "null"
                ? <Widget>[
                    Icon(
                      Icons.add_a_photo_outlined,
                      size: 100,
                      color: Color.fromARGB(255, 97, 211, 87),
                    ),
                    SizedBox(height: 70),
                    CreateSubjectButton(
                      onPressed: () {
                        Momentum.controller<CreateSubjectController>(context)
                            .startWebFilePicker();
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Add Photo",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      width: 250,
                      height: 60,
                    ),
                  ]
                : [
                    Align(
                      alignment: Alignment.topCenter,
                      child: CreateSubjectButton(
                          child: Text(
                            "Discard Subject Image",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Momentum.controller<CreateSubjectController>(
                                    context)
                                .clearPhoto();
                          },
                          width: ScreenUtil().setWidth(200),
                          height: 50),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.network(
                        '${createSubject.subjectImage}' == "null"
                            ? ""
                            : createSubject.subjectImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
          ),
        );
      },
    );
  }
}
