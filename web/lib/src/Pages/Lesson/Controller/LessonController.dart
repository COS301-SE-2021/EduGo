//Todo: Make use of PrintMarker function in the lesson page, once the lesson has been fully created

/*  
void printMarker() async {
    final image = await QrPainter(
      data:
          "Cars Man!! Cars, Jokes. Music!!!!!, we'll actually get this info from the controller , dont stress ",
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.Q,
    ).toImageData(500);
    final blob = Blob([image]);
    final url = Url.createObjectUrlFromBlob(blob);
    final anchor = document.createElement('a') as AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'getName().png';
    document.body.children.add(anchor);
    anchor.click();
    anchor.remove();
  }*/