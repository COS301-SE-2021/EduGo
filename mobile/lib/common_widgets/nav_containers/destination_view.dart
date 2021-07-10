import 'package:flutter/material.dart';
import 'package:mobile/common_widgets/nav_containers/destination.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({Key? key, required this.destination})
      : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.destination.title} Text'),
        backgroundColor: widget.destination.color,
      ),
      backgroundColor: widget.destination.color,
      body: Container(
          //todo get body for pages
          ),
    );
  }
}
