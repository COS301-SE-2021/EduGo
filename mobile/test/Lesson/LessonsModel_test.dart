import 'package:mobile/main.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonsModel.dart';
import 'package:momentum/momentum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  group('Momentum Tester Tool: ', () {
    test('Lessons', () async {
      final tester = MomentumTester(momentum());

      await tester.init();

      final controller = tester.controller<LessonsController>();
      expect(controller != null, true);
      expect(controller, isA<LessonsController>());
      expect(controller?.model, isA<LessonsModel>());
    });

    test('Lessons w/ mock lessons', () async {
      SharedPreferences.setMockInitialValues({});
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('user_token', 'value');
      
      final tester = MomentumTester(momentum(mock: true));

      await tester.init();

      final controller = tester.controller<LessonsController>();
      await controller?.bootstrapAsync();
      expect(controller != null, true);
      expect(controller, isA<LessonsController>());
      expect(controller?.model, isA<LessonsModel>());
      expect(controller?.model.lessons.length, 3);
      expect(controller?.model.lessons[0].title, 'Lesson 1');
      expect(controller?.model.lessons[1].title, 'Lesson 2');
      expect(controller?.model.lessons[2].title, 'Lesson 3');
    });
  });
}