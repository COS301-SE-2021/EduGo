import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/CreateVirtualEntityWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Lessons/View/Widgets/LessonsWidgets.dart';
import 'package:edugo_web_app/src/Pages/ViewLesson/View/Widgets/AddVirtualEntityModelViewer.dart';

import 'Widgets/AddEntityStoreCard.dart';

class AddVirtualEntityView extends StatefulWidget {
  //Info: Virtual Entities Store Card attributes
  @override
  _AddVirtualEntityViewState createState() => _AddVirtualEntityViewState();
}

class _AddVirtualEntityViewState extends State<AddVirtualEntityView> {
  void _virtualEntityAdded() {
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
                  'Virtual entity successfully added',
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
                  MomentumRouter.goto(context, LessonsView);
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
                  color: Colors.amber,
                  size: 100,
                ),
              ),
              Center(
                child: new Text(
                  'Entity is already part of the lesson',
                  style: TextStyle(fontSize: 22, color: Colors.amber),
                ),
              ),
            ],
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                Center(
                  child: new Text(
                    'Please choose another entity and try again.',
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
                  MomentumRouter.pop(context);
                  Momentum.controller<ViewLessonController>(context)
                      .addVirtualEntityLoadControllerReset();
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
    final parameters =
        MomentumRouter.getParam<AddVirtualEntityViewParams>(context);
    return MomentumBuilder(
      controllers: [ViewVirtualEntityController, ViewLessonController],
      builder: (context, snapshot) {
        var addingEntity = snapshot<ViewLessonModel>();

        Future<String> addEntity = Future<String>.delayed(
          const Duration(seconds: 0),
          () {
            if (addingEntity.addViewLoadController == false) return null;
            return "Data loaded";
          },
        );
        return PageLayout(
          top: 0,
          left: 70,
          right: 70,
          child: FutureBuilder(
              future: addEntity,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData)
                  return Container(
                    margin: EdgeInsets.only(top: 0),
                    child: ShaderMask(
                      shaderCallback: (Rect rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.purple,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.purple
                          ],
                          stops: [
                            0.0,
                            0.1,
                            0.9,
                            1.0
                          ], // 10% purple, 80% transparent, 10% purple
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstOut,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: 50, left: 50, right: 50, bottom: 80),
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 40,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 50),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              parameters.name,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 97, 211, 87),
                                                fontSize: 36,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: ScreenUtil().setWidth(400),
                                            height: 500,
                                            child: AddVirtualEntityModelViewer(
                                              currentModel:
                                                  parameters.modelLink,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Material(
                                        borderRadius: BorderRadius.circular(10),
                                        elevation: 40,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 70, vertical: 40),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  LessonsButton(
                                                    onPressed: () {
                                                      MomentumRouter.pop(
                                                          context);
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.arrow_back,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(width: 20),
                                                        Text(
                                                          "Back",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    width: 150,
                                                    height: 60,
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                  ),
                                                  LessonsButton(
                                                    onPressed: () async {
                                                      await Momentum.controller<
                                                                  ViewLessonController>(
                                                              context)
                                                          .addEntityToLesson(
                                                              context,
                                                              entityId:
                                                                  parameters.id,
                                                              addViewLoadController:
                                                                  true)
                                                          .then(
                                                        (value) {
                                                          if (value ==
                                                              "Entity Added") {
                                                            _virtualEntityAdded();
                                                          } else if (value ==
                                                              "Entity Not Added") {
                                                            _virtualEntityNotCreated();
                                                          }
                                                        },
                                                      );
                                                      ;
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(width: 20),
                                                        Text(
                                                          "Add",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    width: 150,
                                                    height: 60,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 100,
                                              ),
                                              Text(
                                                "Description:",
                                                overflow: TextOverflow.visible,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 97, 211, 87),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              SizedBox(
                                                width:
                                                    ScreenUtil().setWidth(300),
                                                child: Text(
                                                  parameters
                                                      .virtualEntityDescription,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                              "Adding ",
                              style: TextStyle(fontSize: 28),
                            ),
                            Text(
                              "Virt",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 97, 211, 87),
                                  fontSize: 28),
                            ),
                            Text(
                              "ual enity...",
                              style: TextStyle(fontSize: 28),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
