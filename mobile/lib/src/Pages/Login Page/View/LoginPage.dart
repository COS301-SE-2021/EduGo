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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                color: Colors.green,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Text(
                      "User",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 60),
                    ),
                    Text(
                      "Login",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 60),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
