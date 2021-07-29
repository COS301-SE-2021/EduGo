import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpMock;
import 'package:mobile/globals.dart';

Future<void> login({required String username, required String password, required http.Client client}) async {
  final response = await client.post(
    Uri.parse("${baseUrl}auth/login"),
    headers: <String, String>{'Content-Type': 'application/json'},
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password
    })
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['token'] != null) {
      
    }
  }
}