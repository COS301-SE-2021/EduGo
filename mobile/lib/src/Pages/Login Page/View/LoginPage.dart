import 'package:flutter/material.dart';
import 'package:mobile/src/Pages/Login%20Page/Controller/LoginPageController.dart';
import 'package:momentum/momentum.dart';

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MomentumBuilder(
//       controllers: [LoginPageController],
//       builder: (context, snapshot) {
//         return Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.height,
//             child: Row(
//               children: [Text("Test 1")],
//             ));
//       },
//     );
//   }
// }

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Text("User", style: TextStyle(color: Colors.black)),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term'),
              ),
            ],
          ),
        ));
  }
}
