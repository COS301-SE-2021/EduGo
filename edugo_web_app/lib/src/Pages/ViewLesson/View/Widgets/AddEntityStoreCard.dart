import 'package:edugo_web_app/src/Pages/EduGo.dart';

class AddEntityStoreCard extends StatefulWidget {
  //Info: Virtual Entities Store Card attributes
  final String name;
  final String virtualEntityDescription;
  final String thumbNailLink;
  final String modelLink;
  final String id;

  AddEntityStoreCard({
    this.id,
    this.name,
    this.modelLink,
    this.virtualEntityDescription,
    this.thumbNailLink,
  });

  @override
  _AddEntityStoreCardState createState() => _AddEntityStoreCardState();
}

class _AddEntityStoreCardState extends State<AddEntityStoreCard> {
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
    //Info: Virtual Entities Store Card user interface
    return MomentumBuilder(
        controllers: [ViewVirtualEntityController],
        builder: (context, snapshot) {
          return Card(
            elevation: 40,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            shadowColor: Colors.green,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                          child: Image.network(
                            widget.thumbNailLink,
                            width: 400,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.name,
                            style: TextStyle(fontSize: 22),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          // child: Text('Entity by: Mr TN Mafaralala'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            MomentumRouter.goto(context, AddVirtualEntityView,
                                params: AddVirtualEntityViewParams(
                                    widget.name,
                                    widget.virtualEntityDescription,
                                    widget.modelLink,
                                    widget.id));
                          },
                          child: Icon(
                            Icons.view_in_ar_outlined,
                            color: Color.fromARGB(255, 97, 211, 87),
                            size: 40,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        Spacer(),
                        MaterialButton(
                          onPressed: () async {
                            await Momentum.controller<ViewLessonController>(
                                    context)
                                .addEntityToLesson(context,
                                    entityId: widget.id,
                                    addStoreLoadController: true)
                                .then(
                              (value) {
                                if (value == "Entity Added") {
                                  _virtualEntityAdded();
                                } else if (value == "Entity Not Added") {
                                  _virtualEntityNotCreated();
                                }
                              },
                            );
                          },
                          child: Icon(
                            Icons.add_to_photos,
                            color: Color.fromARGB(255, 97, 211, 87),
                            size: 40,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class AddVirtualEntityViewParams extends RouterParam {
  final String name;
  final String virtualEntityDescription;
  final String modelLink;
  final String id;

  AddVirtualEntityViewParams(
      this.name, this.virtualEntityDescription, this.modelLink, this.id);
}
