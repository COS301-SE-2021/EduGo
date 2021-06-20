import 'package:edugo_web_app/ui/widgets/EduGoContainer.dart';
import 'package:edugo_web_app/ui/widgets/EduGoPage.dart';
import 'package:flutter/material.dart';

class VirtualEntityStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EduGoPage(
        child: EduGoContainer(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height - 70,
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Create Virtual Entity",
                        style: TextStyle(fontSize: 25))),
                SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}
