import 'package:edugo_web_app/src/Components/Widgets/PageLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VirtualEntityStoreView extends StatefulWidget {
  @override
  State<VirtualEntityStoreView> createState() => _VirtualEntityStoreViewState();
}

class _VirtualEntityStoreViewState extends State<VirtualEntityStoreView> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Virtual Entity Store",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 75),
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.only(
                  right: 30, left: 30, top: 30, bottom: 50),
              crossAxisSpacing: 40,
              mainAxisSpacing: 40,
              crossAxisCount: 4,
              children: getEntities(),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> getEntities() {
  List<Widget> enitites = <Widget>[];
  for (int i = 0; i < 12; i++) {
    enitites.add(
      Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 40,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: const Text('Revolution, they...'),
        ),
      ),
    );
  }
  return enitites;
}
