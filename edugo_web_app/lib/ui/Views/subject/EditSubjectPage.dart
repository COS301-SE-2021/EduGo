import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

import 'SubjectsPage.dart';

class EditSubjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EduGoPage(
      child: Stack(
        children: <Widget>[
          EduGoContainer(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Text("Edit 'ADD SUBJECT NAME HERE DYNAMICALLY'",
                        style: TextStyle(fontSize: 25))),
                SizedBox(height: 35),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 360,
                    width: MediaQuery.of(context).size.width - 360,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 150,
                            width: 1200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 97, 211, 87)),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 15),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "  Subject ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30),
                                        ),
                                        TextSpan(
                                            text: "Tit",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 30)),
                                        TextSpan(
                                            text: "le",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 30)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: 0.9,
                                      child: EduGoInput(
                                        hintText:
                                            "Enter the new Subject Title.",
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 150,
                            width: 1200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 97, 211, 87)),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 15),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "  Subject ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              //fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                        TextSpan(
                                            text: "Gra",
                                            style: TextStyle(
                                                color: Colors.black,
                                                //fontWeight: FontWeight.bold,
                                                fontSize: 30)),
                                        TextSpan(
                                            text: "de",
                                            style: TextStyle(
                                                color: Colors.green,
                                                //fontWeight: FontWeight.bold,
                                                fontSize: 30)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: 0.9,
                                      child: EduGoInput(
                                        hintText:
                                            "Enter the new Subject Grade.",
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 15),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "  Descrip",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30),
                                        ),
                                        TextSpan(
                                            text: "tion",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 30)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: 0.9,
                                      child: EduGoInput(
                                        hintText:
                                            "Enter the new Subject Description.",
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            height: 150,
                            width: 1200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 97, 211, 87)),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 15),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "  Pho",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30),
                                        ),
                                        TextSpan(
                                            text: "to",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 30)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.center,
                                  child: EduGoInput(
                                      // hintText:
                                      //     "Add a new photo for the subject.",
                                      // width: 450
                                      //     DropzoneView(
                                      //   onDrop:
                                      // ),
                                      ),
                                )
                              ],
                            ),
                            height: 200,
                            width: 1200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 97, 211, 87)),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SubjectsPage()),
                                      );
                                    },
                                    minWidth: 50,
                                    height: 60,
                                    color: Color.fromARGB(255, 97, 211, 87),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.close_outlined,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Cancel edit",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 50),
                              Expanded(
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SubjectsPage()),
                                    );
                                  },
                                  minWidth: 50,
                                  height: 60,
                                  color: Color.fromARGB(255, 97, 211, 87),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.done_outlined,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Finish edit",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
