import 'package:mobile/main.dart';
import 'package:mobile/src/Pages/LessonsPage/Controller/LessonController.dart';
import 'package:mobile/src/Pages/LessonsPage/Models/LessonsModel.dart';
import 'package:momentum/momentum.dart';
import 'package:test/test.dart';

void main() {
  group('Momentum Tester Tool: ', () {
    test('Lessons', () async {
      final tester = MomentumTester(momentum());

      await tester.init();

      final lesson = tester.controller<LessonsController>();
      expect(lesson != null, true);
      expect(lesson, isA<LessonsController>());
      expect(lesson?.model, isA<LessonsModel>());
    });

    test('Lessons w/ mock lessons', () async {
      final tester = MomentumTester(momentum(mock: true));

      await tester.init();

      final lesson = tester.controller<LessonsController>();
      await lesson?.bootstrapAsync();
      expect(lesson != null, true);
      expect(lesson, isA<LessonsController>());
      expect(lesson?.model, isA<LessonsModel>());
      expect(lesson?.model.lessons.length, 3);
      expect(lesson?.model.lessons[0].title, 'Lesson 1');
      expect(lesson?.model.lessons[1].title, 'Lesson 2');
      expect(lesson?.model.lessons[2].title, 'Lesson 3');
    });
  });
}