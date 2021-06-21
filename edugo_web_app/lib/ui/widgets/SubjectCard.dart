import 'package:edugo_web_app/ui/Views/subject/EditSubjectPage.dart';
import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  // SubjectCard({
  final String title;
  final String grade;
  final String description;
  SubjectCard({this.title, this.grade, this.description}) {}

  //final double height;
  //final double width;
  //final String path,

  @override
  Widget build(BuildContext context) {
    return
        //Material(
        //elevation: 20,
        // child: Container(
        //   //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        // height: height,
        //   width: width,
        //   //color: Color.fromRGBO(238, 240, 245, 1),
        //   decoration: BoxDecoration(
        //     color: Color.fromRGBO(238, 240, 245, 1),
        //     borderRadius: BorderRadius.only(
        //       topRight: Radius.circular(10),
        //       topLeft: Radius.circular(10),
        //       bottomLeft: Radius.circular(10),
        //       bottomRight: Radius.circular(10),
        //     ),
        //     border: Border.all(
        //       color: Colors.black,
        //       //width: 1,
        //       style: BorderStyle.solid,
        //     ),
        //   ),
        // ),
        Container(
      height: 350,
      width: 280,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Color.fromARGB(255, 97, 211, 87),
        child: Column(
          children: [
            Image.asset("../assets/images/Maths.jpeg"),
            Container(
              child: Row(
                children: <Widget>[
                  // Expanded(
                  //child:
                  Align(
                    alignment: Alignment.centerLeft,
                    // child: SizedBox(
                    //   height: 180,
                    //   child: Text(
                    //     "Grade 12 Maths",
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "$title",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  // ),
                  //SizedBox(width: 20),
                ],
              ),
            ),
            // ListTile(
            //   leading: Icon(Icons.arrow_drop_down_circle),
            //   title: const Text('Card title 1'),
            //   subtitle: Text(
            //     'Secondary Text',
            //     style: TextStyle(color: Colors.black.withOpacity(0.6)),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Text(
            //     'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
            //     style: TextStyle(color: Colors.black.withOpacity(0.6)),
            //   ),
            // ),
            // ButtonBar(
            //   alignment: MainAxisAlignment.start,
            //   children: [
            //     MaterialButton(
            //       textColor: const Color(0xFF6200EE),
            //       onPressed: () {
            //         // Perform some action
            //       },
            //       child: const Text('ACTION 1'),
            //     ),
            //     MaterialButton(
            //       textColor: const Color(0xFF6200EE),
            //       onPressed: () {
            //         // Perform some action
            //       },
            //       child: const Text('ACTION 1'),
            //     ),
            //   ],
            // ),
            // Image.asset('assets/card-sample-image.jpg'),
            // Image.asset('assets/card-sample-image-2.jpg'),
            Align(
              alignment: Alignment.centerLeft,
              // child: SizedBox(
              //   height: 180,
              //   child: Text(
              //     "Grade 12 Maths",
              //     style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "$grade",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              // child: SizedBox(
              //   height: 180,
              //   child: Text(
              //     "Grade 12 Maths",
              //     style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "$description",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditSubjectPage()),
                  );
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        //),
      ),
    );
  }
}
