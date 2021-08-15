import 'package:mobile/src/Pages/HomePage/Models/HomeModel.dart';
import 'package:mobile/src/Pages/HomePage/Service/HomeService.dart';
import 'package:momentum/momentum.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpMock;
import 'package:mobile/mockApi.dart' as mockApi;

class HomeController extends MomentumController<HomeModel> {
  HomeController({this.mock = false});

  bool mock;

  @override
  HomeModel init() {
    return HomeModel(this, upcomingLessons: []);
  }

  @override
  Future<void> bootstrapAsync() {
    final api = service<HomeService>();
    return api.getUpcomingLessons(client: mock ? httpMock.MockClient(mockApi.getUpcomingLessons) : http.Client()).then((lessons) {
      return model.update(upcomingLessons: lessons);
    });
  }
}