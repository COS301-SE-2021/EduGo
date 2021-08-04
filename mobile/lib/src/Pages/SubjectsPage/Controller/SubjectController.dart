import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/mockApi.dart' as mock;
import 'package:mobile/globals.dart';
import 'package:mobile/src/Exceptions.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/Subject.dart';
import 'package:mobile/src/Pages/SubjectsPage/Models/SubjectsModel.dart';
import 'package:momentum/momentum.dart';

Future<List<Subject>> getSubjectsByUser(int userId,
    {required http.Client client}) async {
  final response =
      await client.post(Uri.parse("${baseUrl}subject/getSubjectsByUser"),
          headers: <String, String>{
            "Authorization":
                "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2Mjc5OTA1MDksImV4cCI6MTYyODA3NjkwOX0.Xwx5MqdLnrUT932mTMBPSFgmhHfEkeBtKYfljhXjjNUHM9jogUi9hanGsNTczBlhH317J_r4dpP5YfrDrNWFvuB7TRVNLPBQ4q_wzIqN1NBATII_aPEtF2Cuv_SmdIxYxvKz1TDn8ha5Js4z59qwU9NvI0ZdDuRrnebPqHnSqnfMN5WQk7hz5gStfPvYcl5Tx3QZOSMAHrMGlzVnOdb0Tp2XIDAiT847Hs6hoER_GO-zNo3r2kNP-xzdFA-cbEIWY9bQToLLhQVZBvQV2KRPvMI-rx2pPr8MhrG974xu7gb4p-4LaFPCIBSpHI4JX9gaSG0AuMAQyfZ2SfcpsKilYEdaWHuII6Qr88VfeOusub3ganUiyL3eLbt-9z-2mUcL4GwqvumfjDFlhJm1BkaQtTUwkzcfUgUv77DcGrpE0XTWOWGUuhWWGW-UmxiKUZ8o1cF5gKXiLztVptza2UYNYLmwCAHD_mKRYIRNE0EG1y12H0WQ-uW4NMu55CbmK11Xfxv2HjvOQ-ljRGSRT7N8YmQuZebu2EFi5MPtYysOETEM7uOP-XZh-i1FzN_M6UBU9jN3EKYut9GAk7odgDfVfEXleBKRxQ-Om54NVhfnXjq_qyR9dNz3I8cOwLfnlRof2GgM4UzZGRj7s7wBnK8VvX9OqhFcJLYjeirH9rICOD4",
            "Content-Type": "application/json",
          },
          body: jsonEncode(<String, int>{'user_id': userId}));

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['data'] != null) {
      List<Subject> subjects =
          (json['data'] as List).map((e) => Subject.fromJson(e)).toList();
      return subjects;
    } else
      throw new BadResponse('No data property');
  }
  throw new Exception('Not a code 200');
}

class SubjectsController extends MomentumController<SubjectsModel> {
  @override
  SubjectsModel init() {
    return SubjectsModel(this, subjects: []);
  }

//In main file, make mock false to use actual api called data,
//make mock true to use mock data
  @override
  Future<void> bootstrapAsync() {
    return getSubjectsByUser(1,
            client: mock
                ? httpMock.MockClient(mockApi.getSubjectsByUserClient)
                : http.Client())
        .then((value) {
  void bootstrap() {
    getSubjectsByUser(1, client: mock.getSubjectsByUserClient).then((value) {
      model.update(subjects: value);
    });
  }
}
