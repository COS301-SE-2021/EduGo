import 'dart:convert';

import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/Lesson.dart';
import 'package:mobile/mockApi.dart' as mockApi;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpMock;
import 'package:mobile/globals.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonsModel.dart';
import 'package:momentum/momentum.dart';

Future<List<Lesson>> getLessonsBySubject(int subject_id,
    {required http.Client client}) async {
  final response =
      await client.post(Uri.parse("${baseUrl}lesson/getLessonsBySubject"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            "Authorization":
                "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2MjgyNDc4MTcsImV4cCI6MTYyODMzNDIxN30.LhDkjHixRs7tqVqQFkzdJ9bizg3MFDCvNrfC5vfDiJ-xGtWD0F1H4py3LOn5YSHsFHEeMVn3wJGMik83MloqHF90U0tK3EyPR7KvUq0vA8kDWBIQfVD_dK1S2MApTHR2w0ngkDy_PBMXJ-GY1daCCIqWQIKgO8ysquYwhuJM8ZQ_VK0MUuKZwakby8WZ-mYTm7lD4hYilTFlodzfWy0j5fHwQ9jbivfy_xGWWg5mlRLua4akf3mXLo9a8eMwp_YjNTKLiiBnOLjLFkYG00IRNf_mruEJxePYA4Hd2OVJ4whpVqRh3AhbQhtHXFWiFH94hqcVOcUR3SOYNh3KzT02ocaqtEEoQ7Ncq-Jpc990F7tYH0TPjC5iQ0bp8ibgrGwmmUj5tTNGJ8_-hUcw1687ZS-MQP7Dcuy4a1VN3_82PyKchE_dcYTWI0r0YExum0UOPlHtRrGg4p2gI0Is1JDkd7TqPoS41tXsZ05B8_D3_rcFL1AAuygRVkjILAEj0Qyzn8QLN7ChKAU-rHnPOIBycFaZhGYQsqTectkk-m8FiwH_WjIvs0pQzVsX32U3l9Ny47lAy0kQOLkL4NA5gXFFMer3NvwppaKA96x1RVNoAeb4FXyo-4vYLqkFp7mkx37PTyEFVPSbQN9ki3dsuQN2OCmgWQiP6d5wADTv_q-F6no",
          },
          body: jsonEncode(<String, int>{'subjectId': subject_id}));

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['data'] != null) {
      List<Lesson> lessons =
          (json['data'] as List).map((e) => Lesson.fromJson(e)).toList();
      return lessons;
    } else
      throw new BadResponse('No data property');
  }
  throw Exception('Not a code 200');
}

class LessonsController extends MomentumController<LessonsModel> {
  LessonsController({this.mock = false});

  bool mock;

  @override
  LessonsModel init() {
    return LessonsModel(this, lessons: []);
  }

  Future<void> getLessons(int subjectID) {
    return getLessonsBySubject(subjectID,
            client: mock
                ? httpMock.MockClient(mockApi.getLessonsBySubjectClient)
                : http.Client())
        .then((value) {
      model.update(lessons: value);
    });
  }
}
