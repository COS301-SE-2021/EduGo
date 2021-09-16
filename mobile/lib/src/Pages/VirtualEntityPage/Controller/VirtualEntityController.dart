import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/globals.dart' as globals;
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Http post request for getting virtual entities from baseUrl/virtualEntity/getVirtualEntity endpoint
//Using application/json as content type
//Returns a VirtualEntity object
Future<VirtualEntity> getVirtualEntity(int id,
    {required http.Client client}) async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('user_token') ?? null;

  if (token == null) throw NoToken();

  final response = await client.post(
      Uri.parse("${globals.baseUrl}virtualEntity/getVirtualEntity"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token
      },
      body: jsonEncode(<String, int>{'id': id}));

  if (response.statusCode == 200) {
    return VirtualEntity.fromJson(jsonDecode(response.body));
  }
  throw Exception('Not a code 200');
}
