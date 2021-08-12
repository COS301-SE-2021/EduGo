import 'package:edugo_web_app/src/Pages/EduGo.dart';

class SignInContent extends StatelessWidget {
  List<Widget> pageChildren(double width, context, bool spacer) {
    return <Widget>[
      (spacer)
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Image.asset(
                "../assets/images/EduGoTree.png",
                width: width,
                height: 665,
              ),
            )
          : SizedBox(),
      (spacer) ? SizedBox() : SizedBox(),
      SizedBox(
        height: 200,
      ),
      Material(
        elevation: 40,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 600,
          padding: EdgeInsets.only(top: 50),
          height: 500,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Edu",
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.black,
                          fontWeight: FontWeight.normal)),
                  Text("Go",
                      style: TextStyle(
                          fontSize: 50,
                          color: Color.fromARGB(255, 97, 211, 87),
                          fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 400,
                height: 60,
                child: TextField(
                  onChanged: (value) {},
                  cursorColor: Color.fromARGB(255, 97, 211, 87),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 20),
                    hintText: "UserName",
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 400,
                height: 60,
                child: TextField(
                  onChanged: (value) {},
                  cursorColor: Color.fromARGB(255, 97, 211, 87),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 97, 211, 87), width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 20),
                    hintText: "Password",
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              VirtualEntityButton(
                  elevation: 40,
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    MomentumRouter.goto(context, SubjectsView);
                  },
                  width: 450,
                  height: 65),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: pageChildren(constraints.biggest.width / 2, context, true),
        );
      } else {
        return Column(
            children: pageChildren(constraints.biggest.width, context, false));
      }
    });
  }
}
