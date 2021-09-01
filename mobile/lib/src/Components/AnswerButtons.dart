/**
   * This widget will be a stateless widget and is 
   * responsible for displaying the buttons in the quiz cards. 
*/
import 'package:flutter/material.dart';

/*------------------------------------------------------------------------------
 *                    Answer Buttons used in the Quiz page 
 *------------------------------------------------------------------------------
 */

class AnswerButtons extends StatelessWidget {
  final String answer;

//This is the subject card constructor. it requires 5 arguments to be passed in
  AnswerButtons({required this.answer});

  @override
  Widget build(BuildContext context) {
    //This is the main subject card design. It is all in a container and
    //displays info like the subject photo, subject title, subject educator
    //and how many lessons are in that subject

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //Padding(
        //padding: const EdgeInsets.only(top: 15),
        Expanded(
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              side: BorderSide(color: Colors.red),
            ),
            onPressed: () {},
            minWidth: 5,
            height: 60,
            child: Text(
              "$answer",
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
      ],
    );
  }
}
