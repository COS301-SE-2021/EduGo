import 'package:edugo_web_app/src/Pages/Admin/View/Widgets/AdminWidgets.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class AdminView extends StatelessWidget {
  Widget build(BuildContext context) {
    Momentum.controller<AdminController>(context).getOrganisationId(context);
    return MomentumBuilder(
        controllers: [AdminController],
        builder: (context, snapshot) {
          var currentOrganisation = snapshot<AdminModel>();

          Future<String> educatorsLoaded = Future<String>.delayed(
            const Duration(seconds: 0),
            () {
              if (currentOrganisation.educatorCards.isEmpty) return null;
              return "Data loaded";
            },
          );
          Future<String> educatorsReLoaded = Future<String>.delayed(
            const Duration(seconds: 0),
            () {
              if (currentOrganisation.adminLoadController == false) return null;

              return "Data loaded";
            },
          );
          return FutureBuilder(
              future: educatorsLoaded,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData)
                  return PageLayout(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Stack(
                      children: [
                        Container(
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
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  bottom:
                                                      5, // Space between underline and text
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 97, 211, 87),
                                                      width:
                                                          4.0, // Underline thickness
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  currentOrganisation
                                                      .organisationName,
                                                  style: TextStyle(
                                                    fontSize: 35,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            AdminButton(
                                              onPressed: () {
                                                MomentumRouter.goto(context,
                                                    InviteStudentsView);
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 15),
                                                  Text(
                                                    "Invite Students",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              width: 230,
                                              height: 60,
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().setWidth(40),
                                            ),
                                            AdminButton(
                                              onPressed: () {
                                                MomentumRouter.goto(context,
                                                    InviteEducatorsView);
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 15),
                                                  Text(
                                                    "Invite Educators",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              width: 230,
                                              height: 60,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                content: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 100),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Educators",
                                          style: TextStyle(
                                            fontSize: 32,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      FutureBuilder<String>(
                                          future: educatorsReLoaded,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData)
                                              return Column(
                                                children: currentOrganisation
                                                    .educatorCards,
                                              );
                                            return Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    width: 50,
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
                                                        "Re",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    97,
                                                                    211,
                                                                    87),
                                                            fontSize: 28),
                                                      ),
                                                      Text(
                                                        "freshing",
                                                        style: TextStyle(
                                                            fontSize: 28),
                                                      ),
                                                      Text(
                                                        "...",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    97,
                                                                    211,
                                                                    87),
                                                            fontSize: 28),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          })
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
                              "Welcome to ",
                              style: TextStyle(fontSize: 28),
                            ),
                            Text(
                              "Edu",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 97, 211, 87),
                                  fontSize: 28),
                            ),
                            Text(
                              "Go...",
                              style: TextStyle(fontSize: 28),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
