/**
   * This widget will be a stateless widget and is 
   * responsible for displaying the buttons in the quiz cards. 
*/
import 'package:flutter/material.dart';

/*------------------------------------------------------------------------------
 *                    Answer Buttons used in the Quiz page 
 *------------------------------------------------------------------------------
 */

class AnswerButtons extends StatefulWidget {
  final String answer;

//This is the subject card constructor. it requires 5 arguments to be passed in
  AnswerButtons({required this.answer});

  @override
  _AnswerButtonsState createState() => _AnswerButtonsState();
}

class _AnswerButtonsState extends State<AnswerButtons> {
  bool hasBeenPressed1 = false;
  bool hasBeenPressed2 = false;
  int finalButtonPressed = -1;

  @override
  Widget build(BuildContext context) {
    //Color backgroundColour = Colors.white;
    // if (hasBeenPressed == true) {
    //   hasBeenPressed = true;
    //   backgroundColour = Colors.green;
    // } else {
    //   hasBeenPressed = false;
    //   backgroundColour = Colors.white;
    // }

    //This is the main subject card design. It is all in a container and
    //displays info like the subject photo, subject title, subject educator
    //and how many lessons are in that subject

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            color: hasBeenPressed1 ? Colors.green : Colors.white,
            // color: hasBeenPressed ? backgroundColour : backgroundColour,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  side: BorderSide(color: Colors.black)),
              onPressed: () => setState(() {
                // hasBeenPressed1 = true;
                // hasBeenPressed2 = false;
              }),
              minWidth: 5,
              height: 50,
              child: Text(
                "${widget.answer}",
                maxLines: 2,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              //),
            ),
          ),
        ),
      ],
    );
  }
}
