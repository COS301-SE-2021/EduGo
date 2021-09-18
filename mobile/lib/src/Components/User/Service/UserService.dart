import 'dart:convert';

import 'package:mobile/globals.dart';
import 'package:mobile/src/Components/User/Models/UserModel.dart';
import 'package:mobile/src/Exceptions.dart';
import 'package:momentum/momentum.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserApiService extends MomentumService {
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
      //print(response.body);
      if (json['token'] != null) {
        String token = json['token'] as String;
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('user_token', token);
        //print(token);
        //print(prefs.getString("user_token"));
        return true;
      } else
        throw new BadResponse('No token property');
    } else if (response.statusCode == 401) return false;
    throw new Exception('Unexpected server error');
  }

  Future<User> getUser(
      {String? user_token, required http.Client client}) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('user_token') ?? user_token ?? null;
    // print('token');
    // print(token);
    if (token == null) throw NoToken();

    final response = await client.get(
        Uri.parse("${baseUrl}user/getUserDetails"), //updated from auth/user
        headers: <String, String>{'Authorization': token});
    print('response');
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      User user = User.fromJson(json);
      return user;
    } else if (response.statusCode == 401)
      throw new BadResponse('Unauthorized');
    throw new Exception('Unexpected server error');
  }

  Future<bool> verify(
      {required String email,
      required String code,
      required http.Client client}) async {
    final response = await client.post(
        Uri.parse("${baseUrl}auth/verifyInvitation"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            <String, String>{'email': email, 'verificationCode': code}));
    if (response.statusCode == 200) return true;
    return false;
  }

  Future<bool> register(
      {required String username,
      required String password,
      required String email,
      required String firstName,
      required String lastName,
      // required String organisation_id,
      // required String type,
      required http.Client client}) async {
    final response = await client.post(Uri.parse("${baseUrl}auth/register"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
          'user_email': email,
          'user_firstName': firstName,
          'user_lastName': lastName,
          // 'userType': type,
          // 'organisation_id': organisation_id
        }));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
