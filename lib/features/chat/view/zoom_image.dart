/*import 'package:flutter/material.dart';
import 'package:one_dose_sugar/pages/chat/chat_window.dart';

class ZoomImage extends StatelessWidget {
  final String url;
  static const String id = "ZoomImage";
  ZoomImage({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: new ZoomImageScreen(url: url),
    );
  }
}

class ZoomImageScreen extends StatefulWidget {
  final String url;

  ZoomImageScreen({Key key, @required this.url}) : super(key: key);

  @override
  State createState() => new ZoomImageScreenState(url: url);
}

class ZoomImageScreenState extends State<ZoomImageScreen> {
  final String url;

  ZoomImageScreenState({Key key, @required this.url});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChatWindow.widgetFullPhoto(context, url);
  }
}*/