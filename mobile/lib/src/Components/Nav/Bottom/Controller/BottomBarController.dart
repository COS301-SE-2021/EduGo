import 'package:flutter/material.dart';
import 'package:mobile/src/Components/Nav/Bottom/Model/BottomBarModel.dart';
import 'package:momentum/momentum.dart';

class BottomBarController extends MomentumController<BottomBarModel> {
  @override
  BottomBarModel init() {
    return BottomBarModel(
      this,
      value: 0,
    );
  }

  void activateIcon(int index, BuildContext context, List<Type> widgetOptions) {
    //var value = model.value; // grab the current value
    model.update(value: index); // update state (rebuild widgets)
    //print(model.value); // new or updated value

    //display screen of selected tab
    MomentumRouter.goto(
      context,
      widgetOptions.elementAt(index),
    );
  }
}
