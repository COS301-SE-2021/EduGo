//* Create Virtual Enitity Page
//  Todo : Create a virtual entity by giving it a name,description and a 3D Model

import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Components/CreateVirtualEntityComponents.dart';
import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/CreateVirtualEntityWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateVirtualEntityView extends StatefulWidget {
  @override
  _CreateVirtualEntityViewState createState() =>
      _CreateVirtualEntityViewState();
}

class _CreateVirtualEntityViewState extends State<CreateVirtualEntityView> {
  final _createEntityFormKey = GlobalKey<FormState>();
  final _createQuizFormKey = GlobalKey<FormState>();
  void _virtualEntityCreated() {
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
                  'Virtual entity successfully created',
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

  void _virtualEntityNotCreated() {
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
                  'Could not create virtual entity',
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

  void _uploadModelError() {
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
                  'Could not create virtual entity',
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
                    'Please upload a 3D model and try again!',
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

  void _invalidQuizError() {
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
                  'Could not create virtual entity',
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
                    'Please build a quiz and try again!',
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
      controllers: [CreateVirtualEntityController, QuizBuilderController],
      builder: (context, snapshot) {
        var createEntity = snapshot<CreateVirtualEntityModel>();
        var quizBuilder = snapshot<QuizBuilderModel>();
        Future<String> linkLoaded = Future<String>.delayed(
          const Duration(seconds: 0),
          () {
            if (createEntity.loadingModelLink == true) return null;

            return "Data loaded";
          },
        );
        Future<String> entityCreateLoader = Future<String>.delayed(
          const Duration(seconds: 0),
          () {
            if (createEntity.creatingEntityLoader == true) return null;

            return "Data loaded";
          },
        );
        return FutureBuilder(
            future: entityCreateLoader,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData)
                return FocusWatcher(
                  child: PageLayout(
                    top: 0,
                    left: 80,
                    right: 80,
                    child:
                        //* Content Container
                        ListView(
                      padding: EdgeInsets.only(
                          top: 50, bottom: 70, left: 30, right: 30),
                      children: [
                        Form(
                          key: _createEntityFormKey,
                          child: Column(
                            children: [
                              Material(
                                elevation: 40,
                                borderRadius: BorderRadius.circular(10),
                                shadowColor: Colors.green,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.only(left: 50, right: 50),
                                  child: Row(
                                    children: [
                                      DesktopLeftContainer(
                                          createEntityparentFormKey:
                                              _createEntityFormKey),
                                      Spacer(),
                                      Container(
                                        width: ScreenUtil().setWidth(400),
                                        height: 500,
                                        child: FutureBuilder(
                                          future: linkLoaded,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<String> snapshot) {
                                            if (snapshot.hasData)
                                              return DesktopRightContainer();
                                            return Scaffold(
                                              body: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 100,
                                                      width: 100,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            new AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Color.fromARGB(
                                                                    255,
                                                                    97,
                                                                    211,
                                                                    87)),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Rendering ",
                                                          style: TextStyle(
                                                              fontSize: 28),
                                                        ),
                                                        Text(
                                                          "3D mo",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      97,
                                                                      211,
                                                                      87),
                                                              fontSize: 28),
                                                        ),
                                                        Text(
                                                          "del...",
                                                          style: TextStyle(
                                                              fontSize: 28),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 70,
                              ),
                              Material(
                                elevation: 40,
                                shadowColor: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(50),
                                  child: Column(
                                    children: [
                                      QuizBuilder(
                                          createQuizFormKey:
                                              _createQuizFormKey),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      VirtualEntityButton(
                                          elevation: 40,
                                          child: Text(
                                            "Create Virtual Entity",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            if (createEntity
                                                .modelLink.isEmpty) {
                                              _uploadModelError();
                                              _createEntityFormKey.currentState
                                                  .validate();
                                              _createQuizFormKey.currentState
                                                  .validate();
                                              return;
                                            }

                                            if (!Momentum.controller<
                                                        QuizBuilderController>(
                                                    context)
                                                .validateQuiz(
                                                    _createQuizFormKey)) {
                                              _invalidQuizError();
                                              return;
                                            }
                                            if (_createEntityFormKey
                                                    .currentState
                                                    .validate() &&
                                                _createQuizFormKey.currentState
                                                    .validate())
                                              Momentum.controller<
                                                          CreateVirtualEntityController>(
                                                      context)
                                                  .createVirtualEntity(context)
                                                  .then(
                                                (value) {
                                                  if (value ==
                                                      "Virtual Entity Created") {
                                                    _virtualEntityCreated();
                                                  } else {
                                                    _virtualEntityNotCreated();
                                                  }
                                                },
                                              );
                                          },
                                          width: 450,
                                          height: 65),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
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
                            "virt",
                            style: TextStyle(
                                color: Color.fromARGB(255, 97, 211, 87),
                                fontSize: 28),
                          ),
                          Text(
                            "ual entity...",
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
