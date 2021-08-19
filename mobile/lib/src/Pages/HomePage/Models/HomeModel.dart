import 'package:mobile/src/Pages/HomePage/Controller/HomeController.dart';
import 'package:mobile/src/Pages/HomePage/Models/UpcomingLessonsModels.dart';
import 'package:momentum/momentum.dart';

class HomeModel extends MomentumModel<HomeController> {
  HomeModel(
    HomeController controller,
    {required this.upcomingLessons}
  ) : super(controller);

  final List<UpcomingLesson> upcomingLessons;

  @override
  void update({List<UpcomingLesson>? upcomingLessons}) {
    HomeModel(controller, upcomingLessons: upcomingLessons ?? this.upcomingLessons);
  }
}