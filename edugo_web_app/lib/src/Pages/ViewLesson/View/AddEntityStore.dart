import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Lessons/View/Widgets/LessonsWidgets.dart';

class AddEntityStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Momentum.controller<VirtualEntityStoreController>(context)
        .getAddStore(context);
    //Info: Buiding virtual entities user interface
    return MomentumBuilder(
      controllers: [ViewLessonController, VirtualEntityStoreController],
      builder: (context, snapshot) {
        //Info: reading virtual entity cards from model
        var virtualEntities = snapshot<VirtualEntityStoreModel>();

        var addingEntity = snapshot<ViewLessonModel>();

        Future<String> addEntity = Future<String>.delayed(
          const Duration(seconds: 0),
          () {
            if (addingEntity.addStoreLoadController == false) return null;
            return "Data loaded";
          },
        );

        Future<String> loadEntities = Future<String>.delayed(
          const Duration(seconds: 0),
          () {
            if (virtualEntities.addStoreCards.isEmpty) return null;
            return "Data loaded";
          },
        );
        //Info: rendering subject cards
        return PageLayout(
          top: 0,
          left: 0,
          right: 0,
          child: FutureBuilder(
              future: loadEntities,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData)
                  return Stack(
                    children: [
                      ListView(
                        padding: EdgeInsets.only(
                          top: 0,
                        ),
                        children: <Widget>[
                          StickyHeader(
                            header: Material(
                              elevation: 40,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: EdgeInsets.only(
                                    right: 50, left: 100, top: 25, bottom: 25),
                                child: Row(
                                  children: [
                                    Text(
                                      "Entity Store",
                                      style: TextStyle(
                                        fontSize: 32,
                                      ),
                                    ),
                                    Spacer(),
                                    LessonsButton(
                                      onPressed: () {
                                        MomentumRouter.pop(context);
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
                              ),
                            ),
                            content: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              primary: false,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                  right: 30, left: 30, top: 40, bottom: 80),
                              crossAxisSpacing: 40,
                              mainAxisSpacing: 40,
                              crossAxisCount: 4,
                              childAspectRatio: 1 / 1.1,
                              children: virtualEntities.addStoreCards,
                            ),
                          ),
                        ],
                      )
                    ],
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
                              "Rendering ",
                              style: TextStyle(fontSize: 28),
                            ),
                            Text(
                              "Virt",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 97, 211, 87),
                                  fontSize: 28),
                            ),
                            Text(
                              "ual entities...",
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
