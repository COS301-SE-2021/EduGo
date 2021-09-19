import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/VirtualEntityStore/View/Widgets/VirtualEntitiesStoreWidgets.dart';

class VirtualEntityStoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Info: Getting educator virtual entites from API
    Momentum.controller<VirtualEntityStoreController>(context)
        .getEducatorVirtualEntityStore(context);
    Momentum.controller<ViewVirtualEntityController>(context).reset();

    //Info: Buiding virtual entities user interface
    return MomentumBuilder(
      controllers: [VirtualEntityStoreController],
      builder: (context, snapshot) {
        //Info: reading virtual entity cards from model
        var educatorVirtualEntities = snapshot<VirtualEntityStoreModel>();

        Future<String> entitiesLoaded = Future<String>.delayed(
          const Duration(seconds: 0),
          () {
            if (educatorVirtualEntities.virtualEntityCards.isEmpty) return null;
            return "Data loaded";
          },
        );

        //Info: rendering subject cards
        return PageLayout(
          top: 0,
          left: 0,
          right: 0,
          child: Stack(
            children: [
              FutureBuilder(
                  future: entitiesLoaded,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData)
                      return Container(
                        padding: EdgeInsets.only(top: 0),
                        child: ListView(
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
                                      right: 50,
                                      left: 100,
                                      top: 25,
                                      bottom: 25),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Entity Store",
                                            style: TextStyle(
                                              fontSize: 32,
                                            ),
                                          ),
                                          Spacer(),
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: () {
                                                Momentum.controller<
                                                            VirtualEntityStoreController>(
                                                        context)
                                                    .changePublic(
                                                        true, context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  bottom:
                                                      5, // Space between underline and text
                                                ),
                                                decoration:
                                                    educatorVirtualEntities
                                                            .public
                                                        ? BoxDecoration(
                                                            border: Border(
                                                              bottom:
                                                                  BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        97,
                                                                        211,
                                                                        87),
                                                                width:
                                                                    4.0, // Underline thickness
                                                              ),
                                                            ),
                                                          )
                                                        : BoxDecoration(),
                                                child: Text(
                                                  "Public",
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: () {
                                                Momentum.controller<
                                                            VirtualEntityStoreController>(
                                                        context)
                                                    .changePublic(
                                                        false, context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  bottom:
                                                      5, // Space between underline and text
                                                ),
                                                decoration:
                                                    educatorVirtualEntities
                                                            .public
                                                        ? BoxDecoration()
                                                        : BoxDecoration(
                                                            border: Border(
                                                              bottom:
                                                                  BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        97,
                                                                        211,
                                                                        87),
                                                                width:
                                                                    4.0, // Underline thickness
                                                              ),
                                                            ),
                                                          ),
                                                child: Text(
                                                  "Private",
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          VirtualEntitiesStoreButton(
                                            onPressed: () {
                                              MomentumRouter.goto(context,
                                                  CreateVirtualEntityView);
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(width: 20),
                                                Text(
                                                  "Create Virtual Entity",
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
                                      )
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
                                children:
                                    educatorVirtualEntities.virtualEntityCards,
                              ),
                            ),
                          ],
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
            ],
          ),
        );
      },
    );
  }
}
