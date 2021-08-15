import 'package:mobile/src/Pages/SubjectsPage/Models/SubjectsModel.dart';
import 'package:test/test.dart';
import 'package:mobile/main.dart';
import 'package:mobile/src/Pages/SubjectsPage/Controller/SubjectController.dart';
import 'package:momentum/momentum.dart';

void main() {
  group('Momentum Tester Tool: ', () {
    test('Subjects', () async {
      final tester = MomentumTester(momentum());

      await tester.init();

      final controller = tester.controller<SubjectsController>();
      expect(controller != null, true);
      expect(controller, isA<SubjectsController>());
      expect(controller?.model, isA<SubjectsModel>());
    });

    test('Subjects w/ mock lessons', () async {
      final tester = MomentumTester(momentum(mock: true));

      await tester.init();

      final controller = tester.controller<SubjectsController>();
      await controller?.bootstrapAsync();
      expect(controller != null, true);
      expect(controller, isA<SubjectsController>());
      expect(controller?.model, isA<SubjectsModel>());
      expect(controller?.model.subjects.length, 3);
      expect(controller?.model.subjects[0].title, 'Test subject 1');
      expect(controller?.model.subjects[1].title, 'Test subject 2');
      expect(controller?.model.subjects[2].title, 'Test subject 3');
    });
  });
}