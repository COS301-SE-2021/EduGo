import 'package:edugo_web_app/src/Pages/EduGo.dart';

class VirtualEntityStoreView extends StatelessWidget {
  const VirtualEntityStoreView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* Controller loading virtual entities on build on the VirtualEntityStoreView
    Momentum.controller<VirtualEntityController>(context)
        .getVirtualEntities(context);
    //*
    return MomentumBuilder(
      controllers: [VirtualEntityController],
      builder: (context, snapshot) {
        var entity = snapshot<VirtualEntityModel>();
        bool public = true;
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
                              right: 50, left: 100, top: 25, bottom: 25),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Virtual Entities",
                                    style: TextStyle(
                                      fontSize: 32,
                                    ),
                                  ),
                                  Spacer(),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          bottom:
                                              5, // Space between underline and text
                                        ),
                                        decoration: public
                                            ? BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 97, 211, 87),
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
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          bottom:
                                              5, // Space between underline and text
                                        ),
                                        decoration: !public
                                            ? BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 97, 211, 87),
                                                    width:
                                                        4.0, // Underline thickness
                                                  ),
                                                ),
                                              )
                                            : BoxDecoration(),
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
                                  VirtualEntityButton(
                                    onPressed: () {
                                      MomentumRouter.goto(
                                          context, CreateVirtualEntityView);
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
                      content: public
                          ? GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              primary: false,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                  right: 30, left: 30, top: 50, bottom: 80),
                              crossAxisSpacing: 40,
                              mainAxisSpacing: 40,
                              crossAxisCount: 4,
                              children: entity.virtualEntityStore,
                            )
                          : GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              primary: false,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                  right: 30, left: 30, top: 50, bottom: 80),
                              crossAxisSpacing: 40,
                              mainAxisSpacing: 40,
                              crossAxisCount: 4,
                              children: entity.virtualEntityStore,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
