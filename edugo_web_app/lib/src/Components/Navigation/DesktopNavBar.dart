// * General Desktop Navigation applied on most of the pages inside the web app, for devices with bigger screens

import 'package:edugo_web_app/src/Pages/EduGo.dart';

class DesktopNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 97, 211, 87)),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  width: MediaQuery.of(context).size.width - 100,
                  height: 100,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(children: <Widget>[
                    Text("Edu",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontWeight: FontWeight.normal)),
                    Text("Go",
                        style: TextStyle(
                            fontSize: 40,
                            color: Color.fromARGB(255, 97, 211, 87),
                            fontWeight: FontWeight.bold))
                  ]))
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              height: MediaQuery.of(context).size.height - 100,
              width: 100,
              decoration: BoxDecoration(color: Color.fromRGBO(55, 59, 83, 1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(children: <Widget>[
                    //*
                    //* Dashboard Icon
                    //*
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Icon(Icons.home, size: 30, color: Colors.white),
                        onTap: () {
                          MomentumRouter.goto(context, AdminView);
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    //*
                    //* Subjects Icon
                    //*
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Icon(Icons.auto_stories_outlined,
                            size: 30, color: Colors.white),
                        onTap: () {
                          MomentumRouter.goto(context, SubjectsView);
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    //*
                    //* Create VirtualEntity Icon
                    //*
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Icon(Icons.view_in_ar_outlined,
                            size: 30, color: Colors.white),
                        onTap: () {
                          MomentumRouter.goto(context, CreateVirtualEntityView);
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    //*
                    //* Virtual Entity Store Icon
                    //*
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Icon(Icons.store_outlined,
                            size: 30, color: Colors.white),
                        onTap: () {
                          MomentumRouter.goto(context, VirtualEntityStoreView);
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    //*
                    //* Grades Icon
                    //*
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Icon(Icons.school_outlined,
                            size: 30, color: Colors.white),
                        onTap: () {
                          //MomentumRouter.goto(context, UpdateVirtualEntityView);
                        },
                      ),
                    )
                  ]),
                  //*
                  //* Settings Icon
                  //*
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      child: Icon(Icons.settings_outlined,
                          size: 30, color: Colors.white),
                      onTap: () {},
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
