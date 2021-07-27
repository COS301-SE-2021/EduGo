import 'dart:convert';

import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';

VirtualEntityData validateMarker(String data) {
  if (
    data.length > 13 &&
    data.substring(0, 13) == "EduGo_Marker "
  ) {
    //At this point, the marker has passed the first two checks
    String jsonString = data.substring(13);
    try {
      Map<String, dynamic> json = jsonDecode(jsonString);
      return VirtualEntityData.fromJson(json);
    }
    catch (err) {
      //TODO : Log this error
    }
  }
  throw Exception('Invalid Marker');
}