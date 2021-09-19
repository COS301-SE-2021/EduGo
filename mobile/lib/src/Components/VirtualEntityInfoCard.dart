/**
   * This widget will be a stateless widget and is responsible for 
   * displaying the Virtual entity info as cards. There is just a 
   * string of descrtiptions to be displayed
*/
import 'package:flutter/material.dart';

/*------------------------------------------------------------------------------
 *       Virtual Entity info card used in the Virtual entity page 
 *------------------------------------------------------------------------------
 */

class VirtualEntityInfoCard extends StatelessWidget {
  //Holds the subject title
  final String description;

//This is the virtual card constructor. it requires a list of strings
//Of the descriptions of the virtual entity
  VirtualEntityInfoCard({required this.description});

  @override
  Widget build(BuildContext context) {
    //This is the main subject card design. It is all in a container and
    //displays info like the subject photo, subject title, subject educator

    // return Container(
    //   height: MediaQuery.of(context).size.height,
    //   width: MediaQuery.of(context).size.width / 2,
    //   child: SingleChildScrollView(
    //     scrollDirection: Axis.vertical,
    //     child: Column(
    //       children: [
    //         Card(
    //           elevation: 8.0,
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(8.0),
    //           ),
    //           semanticContainer: true,
    //           clipBehavior: Clip.antiAlias,
    //           color: Colors.white,
    //           child: Padding(
    //             padding: const EdgeInsets.all(5),
    //             // child: FittedBox(
    //             //   fit: BoxFit.contain,
    //             child: Text(
    //               '${description}',
    //               textAlign: TextAlign.left,
    //               overflow: TextOverflow.ellipsis,
    //               maxLines: null,
    //               softWrap: true,
    //               style: TextStyle(
    //                   fontSize: 15,
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.black),
    //             ),
    //             // ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    //);
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 20,
      // MediaQuery.of(context).size.height,
      child: new Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: new Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 4,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              //child: Column(children: [
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '${description}',
                  // "jkebfjewnfjodnfconfibewufbweobfuoewbnfoienfioewbfioeqnfioenfipeqnfouien fk; ejonfkl cjonsaiofn",
                  // textAlign: TextAlign.left,
                  // overflow: TextOverflow.clip,
                  maxLines: null,
                  // softWrap: false,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              //],
            ),
          ),
        ),
      ),
    );
  }
}
