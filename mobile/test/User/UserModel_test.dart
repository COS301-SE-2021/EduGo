import 'package:mobile/main.dart';
import 'package:mobile/src/Components/User/Controller/UserController.dart';
import 'package:mobile/src/Components/User/Models/UserModel.dart';
import 'package:momentum/momentum.dart';
import 'package:test/test.dart';

void main() {
  group('Momentum Tester Tool: ', () {
    test('User Model', () async {
      final tester = MomentumTester(momentum());

      await tester.init();

      final controller = tester.controller<UserController>();
      expect(controller != null, true);
      expect(controller, isA<UserController>());
      expect(controller?.model, isA<UserModel>());
    });
  });
}