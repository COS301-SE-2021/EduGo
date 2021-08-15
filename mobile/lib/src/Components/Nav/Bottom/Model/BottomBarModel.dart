import 'package:mobile/src/Components/Nav/Bottom/Controller/BottomBarController.dart';
import 'package:momentum/momentum.dart';

class BottomBarModel extends MomentumModel<BottomBarController> {
  BottomBarModel(
    BottomBarController controller, {
    required this.value,
  }) : super(controller);

  final int value;

  @override
  void update({
    //page displayed (Momentum go to)
    int? value,
  }) {
    BottomBarModel(
      controller,
      value: value ?? this.value,
    ).updateMomentum();
  }
}
