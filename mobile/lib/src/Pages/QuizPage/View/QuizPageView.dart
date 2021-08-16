import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:mobile/src/Pages/QuizPage/Controller/QuizController.dart';
import 'package:mobile/src/Pages/QuizPage/Model/QuizModel.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Controller/VirtualEntityController.dart';
import 'package:mobile/src/Pages/VirtualEntityPage/Models/VirtualEntityModels.dart';
import 'package:http/http.dart' as http;
import 'package:momentum/momentum.dart';

class QuizView extends StatefulWidget {
  QuizView({Key? key}) : super(key: key);

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  @override
  void initState() {
    super.initState();
  }

  //_QuizViewState();

  /*class Tech {
  String label;
  bool isSelected;
  Tech(this.label, this.isSelected);
}

  //MC
  bool selected = false;
  List<Tech> _chipsList = [
    Tech("Android", false),
    Tech("Flutter", false),
    Tech("Ios", false),
    Tech("Python", false),
    Tech("Go lang", false)
  ];
  //TOF
  String? _value = '';
  String type = 'MC'; //'MC'; //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Choice Chips Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Choice Chips Demo'),
        ),
        body: Column(
          children: List<Widget>.generate(3, (int index) {
            if (type == 'TOF') {
              return ChoiceChip(
                label: Text('Item $index'),
                selected: _value == 'Item $index',
                onSelected: (bool selected) {
                  setState(() {
                    _value = selected ? 'Item $index' : null;
                  });
                },
              );
            } else
              return FilterChip(
                  label: Text(_chipsList[index].label),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: Colors.green,
                  selected: _chipsList[index].isSelected,
                  onSelected: (bool value) {
                    setState(() {
                      _chipsList[index].isSelected = value;
                    });
                  });
          }).toList(),
        ),
      ),
    );}*/
  @override
  Widget build(BuildContext context) {
    //Widg
    return MobilePageLayout(
        false,
        false,
        MomentumBuilder(
            controllers: [QuizController],
            builder: (context, snapshot) {
              final questions = snapshot<QuizModel>();
              final questionController =
                  Momentum.controller<QuizController>(context);

              return Column(); //TODO return children
            }),
        'Quiz');
  }
}
//TODO get virtual entity
