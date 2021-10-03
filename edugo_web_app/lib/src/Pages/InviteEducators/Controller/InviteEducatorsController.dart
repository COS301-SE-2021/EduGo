import 'package:edugo_web_app/src/Pages/EduGo.dart';
import 'package:file_picker/file_picker.dart';

class InviteEducatorsController
    extends MomentumController<InviteEducatorsModel> {
  @override
  InviteEducatorsModel init() {
    return InviteEducatorsModel(this,
        emails: [], emailCards: [], inviteResponse: "init");
  }

  void inputEmail(String email) {
    model.inputEmail(email);
  }

  void addEmail() {
    model.addEmail();
  }

  void removeEmail(int emailId) {
    model.removeEmail(emailId);
  }

  void getEmailView() {
    model.update(emailCards: model.getEmailView());
  }

  Future<String> sendInvitations(context) async {
    model.update(inviteResponse: "");
    var url = Uri.parse(EduGoHttpModule().getBaseUrl() + '/user/addEducators');
    await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            Momentum.controller<AdminController>(context).getToken()
      },
      body: jsonEncode(
        <String, dynamic>{"educators": model.emails},
      ),
    ).then(
      (response) {
        if (response.statusCode == 200) {
          model.update(inviteResponse: "Invitations sent");
          model.update(emails: <String>[]);
          return "Invitations sent";
        }
        model.update(inviteResponse: "Invitations not sent");
        print(response.body);
        return "Invitations not sent";
      },
    );
    return model.inviteResponse;
  }

  PlatformFile selectedFile;
  Future<void> selectCSVFile(context) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        withData: true,
        type: FileType.custom,
        allowedExtensions: ['csv']);

    if (result != null) {
      if (result.files.first.extension == "csv" ||
          result.files.first.extension == "CSV") {
        selectedFile = result.files.first;
        List<String> csvList;
        List<String> csvFileContentList = [];

        String s = new String.fromCharCodes(selectedFile.bytes);
        var outputAsUint8List = new Uint8List.fromList(s.codeUnits);

        csvFileContentList = new List<String>.from(
            new Utf8Decoder().convert(outputAsUint8List).split('\n'));

        if (csvFileContentList.length == 0 ||
            csvFileContentList[1].length == 0) {
          print('CSV file has no content');
          return 'Error: The CSV file has no content.';
        }
        List<String> convertList = csvFileContentList.cast<String>();
        csvList = convertList;
        List<String> tempEmails = model.emails;
        csvList = tempEmails + csvList;
        List<String> finalEmails = [];
        csvList.forEach((email) {
          if (email.contains('\r')) {
            finalEmails.add(email.substring(0, email.length - 2));
          } else {
            finalEmails.add(email);
          }
        });
        model.update(emails: finalEmails);
        getEmailView();
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              insetPadding:
                  EdgeInsets.only(top: 100, bottom: 100, left: 100, right: 100),
              title: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Icon(
                      Icons.warning_rounded,
                      color: Colors.red,
                      size: 100,
                    ),
                  ),
                  Center(
                    child: new Text(
                      'Invalid Email List Uploaded',
                      style: TextStyle(fontSize: 22, color: Colors.red),
                    ),
                  ),
                ],
              ),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: [
                    Center(
                      child: new Text(
                        'Please upload a ".csv" file and try again!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: MaterialButton(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      minWidth: ScreenUtil().setWidth(150),
                      height: 50,
                      child: Text(
                        'Ok',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      color: Color.fromARGB(255, 97, 211, 87),
                      disabledColor: Color.fromRGBO(211, 212, 217, 1),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }
}
