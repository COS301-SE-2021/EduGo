import 'package:edugo_web_app/src/Pages/CreateOrganisation/View/Components/CreateOrganisationContent.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateOrganisationView extends StatelessWidget {
  CreateOrganisationView() : super(key: Key("CreateOrganisationView"));
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
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CreateOrganisationContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
