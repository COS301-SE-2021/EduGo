import 'dart:convert';

import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/HomePage/Models/UpcomingLessonsModels.dart';
import 'package:momentum/momentum.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile/globals.dart';

class HomeService extends MomentumService {
  Future<List<UpcomingLesson>> getUpcomingLessons({required http.Client client}) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('user_token') ?? '';

    final response = await client.post(
      Uri.parse("${baseUrl}recommender/upcomingLessons"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      if (json['lessons'] != null) {
        return json['lessons'].map((lesson) => new UpcomingLesson.fromJson(lesson));
      }
      throw BadResponse('No lessons');
    }
    throw Exception('Not a code 200');
  }
}