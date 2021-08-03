import 'package:flutter/foundation.dart';

class EduGoModel extends ChangeNotifier {
  String EduGoModelLink = "";
  EduGoModel() {}
  String get3DModelLink() {
    return EduGoModelLink;
  }

  set3DModelLink(String link) {
    EduGoModelLink = link;
    notifyListeners();
  }
}
