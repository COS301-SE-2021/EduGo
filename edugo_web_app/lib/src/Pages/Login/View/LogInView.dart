import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:edugo_web_app/src/Pages/Login/View/Components/LogInComponents.dart';

class LogInView extends StatelessWidget {
  LogInView() : super(key: Key("LogInView"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(20, 195, 50, 1.0),
              Color.fromRGBO(11, 36, 54, 1.0)
            ],
          ),
        ),
        child: LogInContent(),
      ),
    );
  }
}
