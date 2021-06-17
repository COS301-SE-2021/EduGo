import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:edugo_web_app/ui/widgets/input_fields/EduGoInput.dart';
import 'package:flutter/material.dart';

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
                    decoration: BoxDecoration(
                        //border: Border.all(color: Colors.black),
                        ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          //SizedBox(height: 100),
                          Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 15),
                                Align(
                                  alignment: Alignment.topLeft,
                                  // child: Text(
                                  //   "   Subject ",
                                  //   style: TextStyle(
                                  //       fontSize: 25, color: Colors.green),
                                  // ),
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
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: EduGoInput(
                                      hintText:
                                          "Enter the new details for the subject grade",
                                      width: 450),
                                )
                              ],
                            ),
                            //height: MediaQuery.of(context).size.height - 0,
                            //width: MediaQuery.of(context).size.width - 0,
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
