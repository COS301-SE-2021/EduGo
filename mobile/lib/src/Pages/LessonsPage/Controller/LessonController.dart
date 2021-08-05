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
                "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2MjgxNjEwMDQsImV4cCI6MTYyODI0NzQwNH0.ZKK2v1m__JJuqrTpdmq1pmAlNchID84GwFKeBfgLO20K42vDtpf0IwZFrW68Ko4Tqj6Ft_Nz3zfDnbeFIQtlEk1kM7KP0vbe5Xad8knB1XX1OsOlweYcUUUlKiZnu4g0_bsQp4DDv2sjHFh1QBREkeA3kA3HUzg3MxN7XO44WzXM0sUEdmV6l5O3FtWkmqTgUEqzoG4mN058qxkaUG9HQC6UQMGiu4wOSX6oqfx8hrtUmGlgA6NgQgcJC8xYa8Ox_-L1yoBYyxkg3cPHYGtVWmABcNG3eNJamGUssbb51Hxy0JQXVtJ57vcYK0f0eUVxemb2JFnAQbAzKiXz37NDHeqytjbGsE_M2XRuLb4J2IjWRVL5DvTpwtHJJD5_IVidRQ-S0YGmdO5suEPA2T9veKay2p9-i2KMfrKFqHcNpASeFspdJ1Oh47VJZGRAhrer_h-JnJKDDB0ugUCXvMFOTxhWegLmJzzQlVaToKsjtzSpZ9CEm2szoHA4rarUnn9S5neY3fNknPiOvD1dHcrOWOd4E-mmcLOjD8YSvrnB1UH31kkNL43NR2BPrRxHQ477slTMi3qBBLs1a3JZxO_jd0NNy174JWVJkwSNLvYmGe9i3iHQjDfCL77Uqa6iaKsCJbP__E9-Ly0ILyzw3XUL1t8BtQ2yqt_TRwg3MnawuKo",
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
