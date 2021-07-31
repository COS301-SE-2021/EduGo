import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpMock;
import 'package:mobile/mockApi.dart' as mockApi;
import 'package:mobile/globals.dart';
import 'package:mobile/src/Components/User/Models/UserModel.dart';
import 'package:mobile/src/Exceptions.dart';
import 'package:momentum/momentum.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Momentum controller for the User Controller 
class UserController extends MomentumController<UserModel> {
  UserController({this.mock = false});

  bool mock;

  @override
  UserModel init() {
    return UserModel(this);
  }

  Future<bool> login({required String username, required String password}) {
    return _login(username: username, password: password, client: mock == true ? httpMock.MockClient(mockApi.loginClient) : http.Client());
  }

  //TODO: Logout


  Future<void> loadUser() {
    return _loadUser(client: mock == true ? httpMock.MockClient(mockApi.loadUserClient) : http.Client());
  }

  Future<bool> _login({required String username, required String password, required http.Client client}) async {
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
        String token = json['token'] as String;
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('user_token', token);
        return true;
      }
      else throw new BadResponse('No token property');
    }
    else if (response.statusCode == 401) return false;
    throw new Exception('Unexpected server error');
  }

  Future<void> _loadUser({String? user_token, required http.Client client}) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('user_token') ?? user_token ?? null;

    if (token == null) throw NoToken();

    final response = await client.post(
      Uri.parse("${baseUrl}auth/user"),
      headers: <String, String>{'Authorization': 'Bearer ' + token}
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      User user = User.fromJson(json);
      model.update(user: user);
    }
    else if (response.statusCode == 401) throw new BadResponse('Unauthorized');
    throw new Exception('Unexpected server error');
  }
}