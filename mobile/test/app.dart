//this file contains the method that enables Flutter driver extension
//followed by calling the function which contains the widgets we need to test
import 'package:flutter_driver/driver_extension.dart';
import 'package:mobile/main.dart' as app;

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();

  // Call the `main()` function of the app
  app.main();
}
