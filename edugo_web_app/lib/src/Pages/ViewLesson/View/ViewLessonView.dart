import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Lessons/View/Widgets/LessonsWidgets.dart';
import 'package:edugo_web_app/src/Pages/ViewLesson/View/Widgets/ViewLessonWidgets.dart';

class ViewLessonView extends StatefulWidget {
  @override
  _ViewLessonViewState createState() => _ViewLessonViewState();
}

class _ViewLessonViewState extends State<ViewLessonView> {
  Widget setupEntitiesDialoagContainer() {
    Momentum.controller<VirtualEntityStoreController>(context)
        .getAddStore(context, viewFunction: ({name, description, id}) {
      Navigator.of(context).pop();
      _viewEntity(name: name, description: description, id: id);
    }, addFunction: () {
      Navigator.of(context).pop();
      _addEntity();
    });
    return MomentumBuilder(
        controllers: [VirtualEntityStoreController],
        builder: (context, snapshot) {
          var store = snapshot<VirtualEntityStoreModel>();
          return Container(
            width: ScreenUtil().setWidth(1200),
            height: ScreenUtil().setHeight(1200),
            child: ListView(
              children: [
                GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                        right: 30, left: 30, top: 40, bottom: 80),
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 40,
                    crossAxisCount: 4,
                    childAspectRatio: 1 / 1.1,
                    children: store.addStoreCards),
              ],
            ),
          );
        });
  }

  Widget setupViewEntityDialoagContainer({name, description, id}) {
    return Container(
      width: ScreenUtil().setWidth(1300),
      height: ScreenUtil().setHeight(1200),
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 80),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 70, vertical: 50),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            name,
                            style: TextStyle(
                              color: Color.fromARGB(255, 97, 211, 87),
                              fontSize: 36,
                            ),
                          ),
                        ),
                        Container(
                            width: ScreenUtil().setWidth(400),
                            height: 500,
                            child: null),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Row(
                          children: [
                            LessonsButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _addEntity();
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
                              onPressed: () {
                                Momentum.controller<ViewLessonController>(
                                        context)
                                    .addEntityToLesson(context, entityId: id);
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
                        Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 40,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 70, vertical: 40),
                            child: Column(
                              children: [
                                Text(
                                  "Description:",
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 97, 211, 87),
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: ScreenUtil().setWidth(300),
                                  child: Text(
                                    description,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(fontSize: 20),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addEntity() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: null,
          content: setupEntitiesDialoagContainer(),
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
                  'Cancel',
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

  void _viewEntity({name, description, id}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: null,
          content: setupViewEntityDialoagContainer(
              name: name, description: description, id: id),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //Info: Getting lesson information from API

    //Info: Buiding lesson display interface
    return MomentumBuilder(
        controllers: [ViewLessonController],
        builder: (context, snapshot) {
          var viewLesson = snapshot<ViewLessonModel>();

          //Info: rendering lesson display
          return PageLayout(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 0),
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                        right: 70, left: 70, top: 50, bottom: 80),
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        elevation: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.only(
                              right: 50, left: 50, top: 50, bottom: 70),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    viewLesson.lessonTitle,
                                    style: TextStyle(
                                      fontSize: 32,
                                    ),
                                  ),
                                  Spacer(),
                                  LessonsButton(
                                    onPressed: () {
                                      MomentumRouter.goto(context, LessonsView);
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
                                    width: 250,
                                    height: 60,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Material(
                                elevation: 40,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.only(
                                      right: 25, left: 25, top: 25, bottom: 25),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Des",
                                            style: TextStyle(
                                                fontSize: 32,
                                                color: Color.fromARGB(
                                                    255, 97, 211, 87)),
                                          ),
                                          Text(
                                            "cription",
                                            style: TextStyle(
                                              fontSize: 32,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(viewLesson.lessonDescription),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Material(
                                elevation: 40,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.only(
                                      right: 50, left: 50, top: 25, bottom: 50),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Virtual",
                                            style: TextStyle(fontSize: 32),
                                          ),
                                          Text(
                                            " Entities",
                                            style: TextStyle(
                                              fontSize: 32,
                                              color: Color.fromARGB(
                                                  255, 97, 211, 87),
                                            ),
                                          ),
                                          Spacer(),
                                          Flexible(
                                            child: Row(
                                              children: [
                                                MouseRegion(
                                                  cursor:
                                                      SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                    child: Icon(
                                                      Icons.computer_outlined,
                                                      size: 30,
                                                      color: Color.fromARGB(
                                                          255, 97, 211, 87),
                                                    ),
                                                    onTap: () {
                                                      Momentum.controller<
                                                                  CanvasController>(
                                                              context)
                                                          .getCanvasView(
                                                        context,
                                                        Momentum.controller<
                                                                    ViewLessonController>(
                                                                context)
                                                            .getEntityId()
                                                            .toString(),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Spacer(),
                                                LessonsButton(
                                                  onPressed: () {
                                                    _addEntity();
                                                  },
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons
                                                            .view_in_ar_outlined,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 20),
                                                      Text(
                                                        "Add Virtual Entity",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  width: 250,
                                                  height: 60,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Column(
                                                children: viewLesson
                                                    .lessonVirtualEntityCards),
                                          ),
                                          Spacer(),
                                          ViewLessonVirtualEntityModelViewer()
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
