import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateSubjectView extends StatelessWidget {
  const CreateSubjectView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [],
      builder: (context, snapshot) {
        return PageLayout(
          top: 50,
          left: 150,
          right: 150,
          child: Stack(children: [
            //* Title Row
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Create Subject",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(100),
                )
              ],
            ),
            //* Content Container
            Container(
              padding: EdgeInsets.only(top: 75),
              child: ListView(
                padding: EdgeInsets.only(bottom: 30),
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: ScreenUtil().setHeight(200),
                      ),
                      CreateSubjectDesktopLeftContainer(),
                      SizedBox(
                        width: ScreenUtil().setWidth(270),
                      ),
                      CreateSubjectDesktopRightContainer(),
                    ],
                  )
                ],
              ),
            ),
          ]),
        );
//           PageLayout(
//             top: 0,
//             left: 0,
//             right: 0,
//             child:Stack(
//         children: <Widget>[
//  Column(
//               children: <Widget>[
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Text("Create Subject", style: TextStyle(fontSize: 25)),
//                 ),
//                 SizedBox(height: 30),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Row(
//                     children: [
//                       Container(
//                         height: MediaQuery.of(context).size.height - 360,
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: <Widget>[
//                               SizedBox(height: 25),
//                               SizedBox(
//                                   width: 450,
//                                   child: TextField(

//                                     cursorColor:
//                                         Color.fromARGB(255, 97, 211, 87),
//                                     decoration: InputDecoration(
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 97, 211, 87),
//                                               width: 2.0),
//                                         ),
//                                         border: OutlineInputBorder(),
//                                         hintText: 'Enter the subject name'),
//                                   )),
//                               SizedBox(height: 20),
//                               SizedBox(
//                                   width: 450,
//                                   child: TextField(

//                                     cursorColor:
//                                         Color.fromARGB(255, 97, 211, 87),
//                                     decoration: InputDecoration(
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 97, 211, 87),
//                                               width: 2.0),
//                                         ),
//                                         border: OutlineInputBorder(),
//                                         hintText: 'Enter the subject grade'),
//                                   )),
//                               SizedBox(height: 25),
//                               SizedBox(
//                                 width: 450,
//                                 child: TextField(

//                                   cursorColor: Color.fromARGB(255, 97, 211, 87),
//                                   decoration: InputDecoration(
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: const BorderSide(
//                                             color: Color.fromARGB(
//                                                 255, 97, 211, 87),
//                                             width: 2.0),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                       hintText:
//                                           'Enter the subject description'),
//                                   keyboardType: TextInputType.multiline,
//                                   maxLines: 4,
//                                 ),
//                               ),
//                               SizedBox(height: 20),
//                               MaterialButton(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10))),
//                                 onPressed: () {

//                                 },
//                                 minWidth: 400,
//                                 height: 60,
//                                 color: Color.fromARGB(255, 97, 211, 87),
//                                 child: Row(
//                                   children: <Widget>[
//                                     Icon(
//                                       Icons.done_outlined,
//                                       color: Colors.white,
//                                     ),
//                                     Text("Add Subject",
//                                         style: TextStyle(color: Colors.white)),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 20),
//                               MaterialButton(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10))),
//                                 onPressed: () {

//                                 },
//                                 minWidth: 400,
//                                 height: 60,
//                                 color: Color.fromARGB(255, 97, 211, 87),
//                                 child: Row(
//                                   children: <Widget>[
//                                     Icon(
//                                       Icons.close_outlined,
//                                       color: Colors.white,
//                                     ),
//                                     Text("Cancel",
//                                         style: TextStyle(color: Colors.white)),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 100),
//                       Container(
//                         height: MediaQuery.of(context).size.height - 420,
//                         width: 400,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(40),
//                             topLeft: Radius.circular(40),
//                             bottomLeft: Radius.circular(40),
//                             bottomRight: Radius.circular(40),
//                           ),
//                           border: Border.all(
//                             color: Colors.white,
//                             width: 1,
//                             style: BorderStyle.solid,
//                           ),
//                         ),
//                         child: Column(
//                           children: <Widget>[
//                             Icon(
//                               Icons.add_a_photo_outlined,
//                               size: 100,
//                               color: Color.fromARGB(255, 97, 211, 87),
//                             ),
//                             SizedBox(height: 70),
//                             MaterialButton(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10))),
//                               onPressed: () {},
//                               minWidth: 20,
//                               //height: 40,
//                               color: Color.fromARGB(255, 97, 211, 87),
//                               child: Row(
//                                 children: <Widget>[
//                                   Icon(
//                                     Icons.add_outlined,
//                                     color: Colors.white,
//                                   ),
//                                   Text(
//                                     "Add Photo",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//         ],
//       ),);
      },
    );
  }
}
// import 'package:edugo_web_app/ui/Views/subject/SubjectsPage.dart';
// import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
// import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:file_picker/file_picker.dart';

// class CreateSubjectPage extends StatefulWidget {
//   @override
//   _CreateSubjectPageState createState() => _CreateSubjectPageState();
// }

// class _CreateSubjectPageState extends State<CreateSubjectPage> {
//   static const urlPrefix = 'http://localhost:8080/subject/createSubject';

//   final _subjectTitleController = TextEditingController();
//   String subjectTitle;

//   final _subjectGradeController = TextEditingController();
//   String subjectGrade;

//   final _subjectDescriptionController = TextEditingController();
//   String subjectDescription;

//   void makeRequest() async {
//     final url = Uri.parse('$urlPrefix');
//     var response = await post(url, headers: {
//       'contentType': 'application/json'
//     }, body: {
//       'title': subjectTitle,
//       'description': subjectDescription,
//       'grade': subjectGrade,
//       'educatorId': '3'
//     });
//   }

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is disposed.
//     _subjectTitleController.dispose();
//     _subjectGradeController.dispose();
//     _subjectDescriptionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return EduGoPage(
//       child: Stack(
//         children: <Widget>[
//           EduGoContainer(
//             width: MediaQuery.of(context).size.width - 100,
//             height: MediaQuery.of(context).size.height - 100,
//             child: Column(
//               children: <Widget>[
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Text("Create Subject", style: TextStyle(fontSize: 25)),
//                 ),
//                 SizedBox(height: 30),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Row(
//                     children: [
//                       Container(
//                         height: MediaQuery.of(context).size.height - 360,
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: <Widget>[
//                               SizedBox(height: 25),
//                               SizedBox(
//                                   width: 450,
//                                   child: TextField(
//                                     controller: _subjectTitleController,
//                                     cursorColor:
//                                         Color.fromARGB(255, 97, 211, 87),
//                                     decoration: InputDecoration(
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 97, 211, 87),
//                                               width: 2.0),
//                                         ),
//                                         border: OutlineInputBorder(),
//                                         hintText: 'Enter the subject name'),
//                                   )),
//                               SizedBox(height: 20),
//                               SizedBox(
//                                   width: 450,
//                                   child: TextField(
//                                     controller: _subjectGradeController,
//                                     cursorColor:
//                                         Color.fromARGB(255, 97, 211, 87),
//                                     decoration: InputDecoration(
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 97, 211, 87),
//                                               width: 2.0),
//                                         ),
//                                         border: OutlineInputBorder(),
//                                         hintText: 'Enter the subject grade'),
//                                   )),
//                               SizedBox(height: 25),
//                               SizedBox(
//                                 width: 450,
//                                 child: TextField(
//                                   controller: _subjectDescriptionController,
//                                   cursorColor: Color.fromARGB(255, 97, 211, 87),
//                                   decoration: InputDecoration(
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: const BorderSide(
//                                             color: Color.fromARGB(
//                                                 255, 97, 211, 87),
//                                             width: 2.0),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                       hintText:
//                                           'Enter the subject description'),
//                                   keyboardType: TextInputType.multiline,
//                                   maxLines: 4,
//                                 ),
//                               ),
//                               SizedBox(height: 20),
//                               MaterialButton(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10))),
//                                 onPressed: () {
//                                   setState(() {
//                                     subjectTitle = _subjectTitleController.text;
//                                     subjectGrade = _subjectGradeController.text;
//                                     subjectDescription =
//                                         _subjectDescriptionController.text;
//                                   });
//                                   makeRequest();
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => SubjectsPage()),
//                                   );
//                                 },
//                                 minWidth: 400,
//                                 height: 60,
//                                 color: Color.fromARGB(255, 97, 211, 87),
//                                 child: Row(
//                                   children: <Widget>[
//                                     Icon(
//                                       Icons.done_outlined,
//                                       color: Colors.white,
//                                     ),
//                                     Text("Add Subject",
//                                         style: TextStyle(color: Colors.white)),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 20),
//                               MaterialButton(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10))),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => SubjectsPage()),
//                                   );
//                                 },
//                                 minWidth: 400,
//                                 height: 60,
//                                 color: Color.fromARGB(255, 97, 211, 87),
//                                 child: Row(
//                                   children: <Widget>[
//                                     Icon(
//                                       Icons.close_outlined,
//                                       color: Colors.white,
//                                     ),
//                                     Text("Cancel",
//                                         style: TextStyle(color: Colors.white)),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 100),
//                       Container(
//                         height: MediaQuery.of(context).size.height - 420,
//                         width: 400,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(40),
//                             topLeft: Radius.circular(40),
//                             bottomLeft: Radius.circular(40),
//                             bottomRight: Radius.circular(40),
//                           ),
//                           border: Border.all(
//                             color: Colors.white,
//                             width: 1,
//                             style: BorderStyle.solid,
//                           ),
//                         ),
//                         child: Column(
//                           children: <Widget>[
//                             Icon(
//                               Icons.add_a_photo_outlined,
//                               size: 100,
//                               color: Color.fromARGB(255, 97, 211, 87),
//                             ),
//                             SizedBox(height: 70),
//                             MaterialButton(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10))),
//                               onPressed: () {},
//                               minWidth: 20,
//                               //height: 40,
//                               color: Color.fromARGB(255, 97, 211, 87),
//                               child: Row(
//                                 children: <Widget>[
//                                   Icon(
//                                     Icons.add_outlined,
//                                     color: Colors.white,
//                                   ),
//                                   Text(
//                                     "Add Photo",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }