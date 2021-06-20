import 'package:flutter/material.dart';

class CreateStartTime extends StatefulWidget {
  @override
  _CreateStartTimeState createState() => _CreateStartTimeState();
}

class _CreateStartTimeState extends State<CreateStartTime> {
  TimeOfDay _time = TimeOfDay.now();

  void _selectTime() async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      initialEntryMode: TimePickerEntryMode.input,
    );
    setState(() {
      _time = newTime; //!
    });
  }

  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: MediaQuery.of(context).size.height / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _selectTime,
              child: Text('SELECT START TIME'),
            ),
            SizedBox(height: 8),
            Text(
              'Selected time: ${_time.format(context)}',
            ),
          ],
        ),
      ),
    );
  }
}
