import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/globals.dart';
import 'package:mobile/src/Exceptions.dart';
//import 'package:shared_preferences/shared_preferences.dart';

Future<bool> login(
    {required String username,
    required String password,
    required http.Client client}) async {
  final response = await client.post(Uri.parse("${baseUrl}auth/login"),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}));

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['token'] != null) {
      String token = json['token'] as String;
      //final prefs = await SharedPreferences.getInstance();
      //prefs.setString('user_token', token);
      return true;
    } else
      throw new BadResponse('No token property');
  } else if (response.statusCode == 401) return false;
  throw new Exception('Unexpected server error');
}
