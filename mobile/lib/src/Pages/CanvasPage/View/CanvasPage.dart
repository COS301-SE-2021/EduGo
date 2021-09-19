import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile/src/Components/mobile_page_layout.dart';
import 'package:momentum/momentum.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CanvasParam extends RouterParam {
  final String code;

  CanvasParam({required this.code});
}

class CanvasPage extends StatelessWidget {
  CanvasPage({Key? key}) : super(key: key);
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  late Future<SharedPreferences> prefs;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String code = MomentumRouter.getParam<CanvasParam>(context)!.code;
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    prefs = SharedPreferences.getInstance();

    var canvas = FutureBuilder<SharedPreferences>(
      future: prefs,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String token = snapshot.data!.getString('user_token') ?? '';
          token = token.split(' ')[1];
          String url = 'http://edugo-backend.southafricanorth.cloudapp.azure.com:8083/?code=${code}&token=${token}';
          return WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {_controller.complete(webViewController);},
                debuggingEnabled: true,
          );
        }
        else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Canvas')
            ),
            body: Center(child: Text('There was an error loading the token\n' + snapshot.error.toString())),
          );
        }
        else {
          return Scaffold(
            appBar: AppBar(title: Text('Canvas')),
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );

    return MobilePageLayout(
      false, 
      false,
      false,
      Scaffold(
        body: canvas
      )
      , 
      'Canvas');
    
  }

}