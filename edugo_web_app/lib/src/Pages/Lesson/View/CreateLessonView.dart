import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateLessonView extends StatelessWidget {
  const CreateLessonView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      top: 0,
      left: 100,
      right: 100,
      child: ListView(
        padding: EdgeInsets.only(top: 50, bottom: 100, left: 40, right: 40),
        children: [
          Column(
            children: [
              //* Title Row
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Create Lesson",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CreateLessonDesktopTopContainer(),
              SizedBox(
                height: 40,
              ),
              CreateLessonDesktopBottomContainer(),
            ],
          )
        ],
      ),
    );
  }
}


//  <Widget>[
//               Column(
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child:
//                         Text("Create Lesson", style: TextStyle(fontSize: 25)),
//                   ),
//                   SizedBox(height: 5),
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Row(
//                       children: [
//                         Container(
//                           height: MediaQuery.of(context).size.height - 360,
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: <Widget>[
//                                 SizedBox(height: 25),
//                                 LessonInputBox(
//                                   text: "Enter the lesson name",
//                                 ),
//                                 SizedBox(height: 25),
//                                 LessonMultiLine(
//                                   text: "Enter the lesson description",
//                                 ),
//                                 SizedBox(height: 25),
//                                 // Create entity
//                                 MaterialButton(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10))),
//                                   onPressed: () {
//                                     // Navigator.push(
//                                     //   context,
//                                     //   MaterialPageRoute(
//                                     //       builder: (context) =>
//                                     //           VirtualEntityPage()),
//                                     // );
//                                   },
//                                   minWidth: 400,
//                                   height: 60,
//                                   child: Text("Create Virtual Entity",
//                                       style: TextStyle(color: Colors.white)),
//                                   color: Color.fromARGB(255, 97, 211, 87),
//                                 ),
//                                 //
//                                 SizedBox(height: 25),
//                                 // Upload entity
//                                 MaterialButton(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10))),
//                                   onPressed: () {
//                                     // Navigator.push(
//                                     //   context,
//                                     //   MaterialPageRoute(
//                                     //       builder: (context) =>
//                                     //           VirtualEntityStore()),
//                                     // );
//                                   },
//                                   minWidth: 400,
//                                   height: 60,
//                                   child: Text("Upload Virtual Entity",
//                                       style: TextStyle(color: Colors.white)),
//                                   color: Color.fromARGB(255, 97, 211, 87),
//                                 ),
//                                 //
//                                 SizedBox(height: 15),
//                               ],
//                             ),
//                           ),
//                         ),
                  
//                         Column(
//                           children: <Widget>[
//                             Container(
//                               width: ScreenUtil().setWidth(400),
//                               child: SfDateRangePicker(
//                                 onSelectionChanged: _onSelectionChanged,
//                                 selectionMode:
//                                     DateRangePickerSelectionMode.single,
//                               ),
//                             ),
//                             //CreateDate(),

//                             // CreateStartTime(),
//                             // CreateEndTime(),
//                             // MaterialButton(
//                             //   shape: RoundedRectangleBorder(
//                             //       borderRadius:
//                             //           BorderRadius.all(Radius.circular(10))),
//                             //   onPressed: () {
//                             //     // Navigator.push(
//                             //     //   context,
//                             //     //   MaterialPageRoute(
//                             //     //       builder: (context) => LessonPage()),
//                             //     // );
//                             //   },
//                             //   minWidth: MediaQuery.of(context).size.width / 5,
//                             //   height: 60,
//                             //   child: Text("Add Lesson",
//                             //       style: TextStyle(color: Colors.white)),
//                             //   color: Color.fromARGB(255, 97, 211, 87),
//                             // ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],