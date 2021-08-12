import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CurrentOrganisationController
    extends MomentumController<CurrentOrganisationModel> {
  @override
  CurrentOrganisationModel init() {
    return CurrentOrganisationModel(
      this,
    );
  }

  String getOrganisationName() {
    return model.getOrganisationName();
  }

  String getOrganisationEmail() {
    return model.getOrganisationEmail();
  }

  String getOrganisationPhoneNumber() {
    return model.getOrganisationPhoneNumber();
  }

  Future<void> getOrganisation(context) async {
    var url = Uri.parse('http://localhost:8080/organisation/GetOrganisation');
    await post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              Momentum.controller<SessionController>(context).getToken()
        },
        body: jsonEncode(<String, String>{
          "id": model.getOrganisationId(),
        })).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> _organisation = jsonDecode(response.body);
        model.update(organisationEmail: _organisation["organisation_email"]);
        model.update(organisationName: _organisation["organisation_name"]);
        var subjectObjsJson = jsonDecode(_organisation['subjects']) as List;
        model.update(
            subjects: subjectObjsJson
                .map((subjectJson) => Subject.fromJson(subjectJson))
                .toList());
        return;
      }
    });
  }
}
