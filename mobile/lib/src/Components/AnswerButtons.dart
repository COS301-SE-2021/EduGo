/**
   * This widget will be a stateless widget and is 
   * responsible for displaying the buttons in the quiz cards. 
*/
import 'package:flutter/material.dart';
import 'package:mobile/globals.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/AnswerController.dart';
import 'package:momentum/momentum.dart';

/*------------------------------------------------------------------------------
 *                    Answer Buttons used in the Quiz page 
 *------------------------------------------------------------------------------
 */

class AnswerButtons extends StatefulWidget {
  final String answer;
  final int index;

//This is the subject card constructor. it requires 5 arguments to be passed in
  AnswerButtons({required this.answer, required this.index});

  @override
  _AnswerButtonsState createState() => _AnswerButtonsState(index: index);
}

class _AnswerButtonsState extends State<AnswerButtons> {
  _AnswerButtonsState({required this.index});
  int index;

  bool hasBeenPressed1 = false;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    //This is the main subject card design. It is all in a container and
    //displays info like the subject photo, subject title, subject educator
    //and how many lessons are in that subject

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            //color: hasBeenPressed1 ? Colors.green : Colors.white,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: hasBeenPressed1 ? Colors.green : Colors.white,
            ),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  side: BorderSide(
                      color: hasBeenPressed1 ? Colors.green : Colors.black)),
              onPressed: () {
                setState(
                  () {
                    this.value = value;
                    if (value == false) {
                      this.hasBeenPressed1 = true;
                      this.value = true;
                      // for (int k = 0; k < 10; k++) {
                      //   checkArray.add(false);
                      // }

                    } else {
                      this.hasBeenPressed1 = false;
                      this.value = false;
                    }
                  },
                );
              },
              minWidth: 5,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.answer}",
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  // Checkbox(
                  //   value: this.value,
                  //   onChanged: (bool? value) {
                  //     setState(() {
                  //       this.value = value!;
                  //       if (value == true) {
                  //         this.hasBeenPressed1 = true;
                  //       } else
                  //         this.hasBeenPressed1 = false;
                  //     });
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
    // },
    //);
  }
}
