import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/globals.dart' as globals;
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

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
  throw Exception('Code ' + response.statusCode.toString() + ', Response ' + response.body);
}

Future<File> download(String url) async {
  HttpClientRequest request = await HttpClient().getUrl(Uri.parse(url));
  HttpClientResponse response = await request.close();
  Uint8List bytes = await consolidateHttpClientResponseBytes(response);
  String dir = (await getApplicationDocumentsDirectory()).path;
  String filename = basename(url);
  File file = new File('$dir/$filename');
  await file.writeAsBytes(bytes);
  return file;
}