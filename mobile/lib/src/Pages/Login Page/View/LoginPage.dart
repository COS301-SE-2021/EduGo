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
                padding: const EdgeInsets.only(top: 60),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: TextField(
                        style: TextStyle(),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: "Email"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: TextField(
                        style: TextStyle(),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: "Password"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: MaterialButton(
                        onPressed: () {},
                        height: 60,
                        color: Colors.black,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            Icon(Icons.login_outlined, color: Colors.white),
                          ],
                        ),
                      ),
                    )
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
