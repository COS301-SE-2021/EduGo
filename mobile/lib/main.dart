import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> fetchModels() {
  return http.post(Uri.parse('http://localhost:8080/virtualEntity/getTestModels'));
}