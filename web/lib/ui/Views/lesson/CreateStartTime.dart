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
        height: 80,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: _selectTime,
                minWidth: 400,
                height: 60,
                child: Text("SELECT START TIME",
                    style: TextStyle(color: Colors.white)),
                color: Color.fromARGB(255, 97, 211, 87),
              ),
            ]),
      ),
    );
  }
}
