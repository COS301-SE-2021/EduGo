import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'Components/HomeComponents.dart';

class Home extends StatelessWidget {
  Home() : super(key: Key("HomeView"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(20, 195, 50, 1.0),
                Color.fromRGBO(11, 36, 54, 1.0)
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HomeNavigation(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: HomeContent(),
              ),
              HomeFooter()
            ],
          ),
        ),
      ),
    );
  }
}
