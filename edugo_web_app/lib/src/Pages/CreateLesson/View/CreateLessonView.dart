import 'package:edugo_web_app/src/Pages/CreateLesson/View/Components/CreateLessonComponents.dart';
import 'package:edugo_web_app/src/Pages/CreateLesson/View/Widgets/CreateLessonWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateLessonView extends StatefulWidget {
  const CreateLessonView({
    Key key,
  }) : super(key: key);

  @override
  _CreateLessonViewState createState() => _CreateLessonViewState();
}

class _CreateLessonViewState extends State<CreateLessonView> {
  final _createLessonFormKey = GlobalKey<FormState>();
  void _lessonCreated() {
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
                  'Lesson successfully created',
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

  void _lessonNotCreated() {
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
                  'Could not create lesson',
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
      controllers: [CreateLessonController],
      builder: (context, snapshot) {
        var createLesson = snapshot<CreateLessonModel>();

        Future<String> createLessonLoad = Future<String>.delayed(
          const Duration(seconds: 0),
          () {
            if (createLesson.createLessonLoadController == false) return null;

            return "Data loaded";
          },
        );

        return FutureBuilder(
            future: createLessonLoad,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData)
                return PageLayout(
                  top: 50,
                  left: 150,
                  right: 150,
                  child: Form(
                    key: _createLessonFormKey,
                    child: Stack(
                      children: [
                        //* Title Row
                        Row(
                          children: [
                            Text(
                              "Create Lesson",
                              style: TextStyle(
                                fontSize: 32,
                              ),
                            ),
                            Spacer(),
                            CreateLessonButton(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    Text(
                                      " Back",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  MomentumRouter.goto(context, LessonsView);
                                },
                                width: ScreenUtil().setWidth(200),
                                height: 50)
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 75),
                          child: ListView(
                            padding: EdgeInsets.only(bottom: 30),
                            children: [
                              CreateLessonContainer(
                                createLessonParentKey: _createLessonFormKey,
                                containerOnSubmit: () async {
                                  if (_createLessonFormKey.currentState
                                      .validate()) {
                                    await Momentum.controller<
                                            CreateLessonController>(context)
                                        .createLesson(context)
                                        .then(
                                      (value) {
                                        if (value == "Lesson created") {
                                          _lessonCreated();
                                        } else {
                                          _lessonNotCreated();
                                        }
                                      },
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              CreateLessonButton(
                                  elevation: 40,
                                  child: Text(
                                    "Create Lesson",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_createLessonFormKey.currentState
                                        .validate()) {
                                      await Momentum.controller<
                                              CreateLessonController>(context)
                                          .createLesson(context)
                                          .then(
                                        (value) {
                                          if (value == "Lesson created") {
                                            _lessonCreated();
                                          } else {
                                            _lessonNotCreated();
                                          }
                                        },
                                      );
                                    }
                                  },
                                  width: 00,
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
                            "les",
                            style: TextStyle(
                                color: Color.fromARGB(255, 97, 211, 87),
                                fontSize: 28),
                          ),
                          Text(
                            "son...",
                            style: TextStyle(fontSize: 28),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
