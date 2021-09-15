import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/CanvasPage/View/CanvasPage.dart';
import 'package:momentum/momentum.dart';

class CanvasCodePage extends StatefulWidget {
  const CanvasCodePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}

class CanvasCodeState extends State<CanvasCodePage> {
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Canvas Code:'),
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter the canvas code"
              )
            ),
            MaterialButton(
              onPressed: () => {MomentumRouter.goto(context, CanvasPage, params: CanvasPage(code: codeController.text))},
              elevation: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              height: 60,
              color: Color.fromARGB(255, 97, 211, 87),
              disabledColor: Color.fromRGBO(211, 212, 217, 1),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Join Canvas",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  Icon(Icons.login_outlined, color: Colors.white),
                ],
              ),
            )
          ],
        )
      )
    );
  }

}