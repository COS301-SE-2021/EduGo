import 'package:edugo_web_app/src/Pages/CreateSubject/View/Components/CreateSubjectComponents.dart';
import 'package:edugo_web_app/src/Pages/CreateSubject/View/Widgets/CreateSubjectWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateSubjectView extends StatefulWidget {
  const CreateSubjectView({Key key}) : super(key: key);

  @override
  _CreateSubjectViewState createState() => _CreateSubjectViewState();
}

class _CreateSubjectViewState extends State<CreateSubjectView> {
  final _createSubjectFormKey = GlobalKey<FormState>();

  void _uploadImageError() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          insetPadding:
              EdgeInsets.only(top: 100, bottom: 100, left: 100, right: 100),
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                  size: 100,
                ),
              ),
              Center(
                child: new Text(
                  'Could not create subject',
                  style: TextStyle(fontSize: 22, color: Colors.red),
                ),
              ),
            ],
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Center(
                  child: new Text(
                    'Please upload an image and try again!',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                  child: MaterialButton(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                minWidth: ScreenUtil().setWidth(150),
                height: 50,
                child: Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                color: Color.fromARGB(255, 97, 211, 87),
                disabledColor: Color.fromRGBO(211, 212, 217, 1),
              )),
            ),
          ],
        );
      },
    );
  }

  void _subjectCreated() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          insetPadding:
              EdgeInsets.only(top: 100, bottom: 100, left: 100, right: 100),
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Icon(
                  Icons.done_rounded,
                  color: Color.fromARGB(255, 97, 211, 87),
                  size: 100,
                ),
              ),
              Center(
                child: new Text(
                  'Subject successfully created',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                  child: MaterialButton(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                minWidth: ScreenUtil().setWidth(150),
                height: 50,
                child: Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                color: Color.fromARGB(255, 97, 211, 87),
                disabledColor: Color.fromRGBO(211, 212, 217, 1),
              )),
            ),
          ],
        );
      },
    );
  }

  void _subjectNotCreated() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          insetPadding:
              EdgeInsets.only(top: 100, bottom: 100, left: 100, right: 100),
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                  size: 100,
                ),
              ),
              Center(
                child: new Text(
                  'Could not create subject',
                  style: TextStyle(fontSize: 22, color: Colors.red),
                ),
              ),
            ],
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Center(
                  child: new Text(
                    'A server error might have occurred, Please try again.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                  child: MaterialButton(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                minWidth: ScreenUtil().setWidth(150),
                height: 50,
                child: Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                color: Color.fromARGB(255, 97, 211, 87),
                disabledColor: Color.fromRGBO(211, 212, 217, 1),
              )),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CreateSubjectController],
      builder: (context, snapshot) {
        var createSubject = snapshot<CreateSubjectModel>();

        Future<String> createSubjectLoad = Future<String>.delayed(
          const Duration(seconds: 0),
          () {
            if (createSubject.createSubjectLoadController == false) return null;

            return "Data loaded";
          },
        );

        return FutureBuilder(
          future: createSubjectLoad,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData)
              return PageLayout(
                top: 50,
                left: 150,
                right: 150,
                child: Form(
                  key: _createSubjectFormKey,
                  child: Stack(
                    children: [
                      //* Title Row
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Create Subject",
                              style: TextStyle(
                                fontSize: 32,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(100),
                          )
                        ],
                      ),
                      //* Content Container
                      Container(
                        padding: EdgeInsets.only(top: 75),
                        child: ListView(
                          padding: EdgeInsets.only(bottom: 30),
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: ScreenUtil().setHeight(200),
                                ),
                                CreateSubjectDesktopLeftContainer(
                                  imageError: () {
                                    _uploadImageError();
                                  },
                                  subjectNotCreatedError: () {
                                    _subjectNotCreated();
                                  },
                                  subjectCreatedError: () {
                                    _subjectCreated();
                                  },
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(270),
                                ),
                                CreateSubjectDesktopRightContainer(),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            CreateSubjectButton(
                                elevation: 40,
                                child: Text(
                                  "Create Subject",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_createSubjectFormKey.currentState
                                      .validate()) {
                                    if ('${createSubject.subjectImage}' ==
                                        "null")
                                      _uploadImageError();
                                    else
                                      await Momentum.controller<
                                              CreateSubjectController>(context)
                                          .createSubject(context)
                                          .then(
                                        (value) {
                                          if (value == "Subject created") {
                                            _subjectCreated();
                                            Momentum.controller<
                                                        CreateSubjectController>(
                                                    context)
                                                .reset();
                                          } else {
                                            if (value ==
                                                "Subject not created") {
                                              _subjectNotCreated();
                                            }
                                          }
                                        },
                                      );
                                  }
                                },
                                width: 465,
                                height: 65),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 97, 211, 87)),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Creating ",
                          style: TextStyle(fontSize: 28),
                        ),
                        Text(
                          "sub",
                          style: TextStyle(
                              color: Color.fromARGB(255, 97, 211, 87),
                              fontSize: 28),
                        ),
                        Text(
                          "ject...",
                          style: TextStyle(fontSize: 28),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}



//  await Momentum.controller<CreateSubjectController>(
//                                   context)
//                               .createSubject(context)
//                               .then(
//                             (value) {
//                               if (value == "Subject created") {
//                                 _subjectCreated();
//                                 Momentum.controller<CreateSubjectController>(
//                                         context)
//                                     .reset();
//                               } else {
//                                 if (value == "Subject not created") {
//                                   _subjectNotCreated();
//                                 }
//                               }
//                             },
//                           );