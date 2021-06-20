import 'package:flutter/material.dart';

class CreateDate extends StatefulWidget {
  @override
  _CreateDateState createState() => _CreateDateState();
}

class _CreateDateState extends State<CreateDate> {
  void _selectDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  DateTime _date = DateTime(2020, 11, 17);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectDate,
              child: Text('SELECT DATE'),
            ),
            SizedBox(height: 8),
            Text(
              'Selected date: $_date',
            ),
          ],
        ),
      ),
    );
  }
}
