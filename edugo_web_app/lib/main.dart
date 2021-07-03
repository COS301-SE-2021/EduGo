import 'package:edugo_web_app/src/Pages/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1440, 1024),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EduGo',
        theme: ThemeData(
            primaryColor: Color.fromARGB(255, 97, 211, 87),
            primarySwatch: Colors.blue,
            fontFamily: "Montserrat"),
        home: Home(),
      ),
    );
  }
}
