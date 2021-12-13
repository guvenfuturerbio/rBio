import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  static _ProgressDialogState state;
  bool isShowing() {
    return state != null && state.mounted;
  }

  @override
  createState() => state = _ProgressDialogState();
}

class _ProgressDialogState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CircularProgressIndicator());
  }
}
