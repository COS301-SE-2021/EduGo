import 'package:flutter/material.dart';

class CreateEndTime extends StatefulWidget {
  @override
  _CreateEndTimeState createState() => _CreateEndTimeState();
}

class _CreateEndTimeState extends State<CreateEndTime> {
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

/*
 MaterialButton(
    shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(10))),
    //onpressed,
    minWidth: 400,
    height: 60,
    child: Text("Upload Virtual Entity",
        style: TextStyle(color: Colors.white)),
    color: Color.fromARGB(255, 97, 211, 87),
*/
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 80, //height: MediaQuery.of(context).size.height / 5,
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
              child: Text("SELECT END TIME",
                  style: TextStyle(color: Colors.white)),
              color: Color.fromARGB(255, 97, 211, 87),
            ),
          ],
        ),
      ),
    );
  }
}
